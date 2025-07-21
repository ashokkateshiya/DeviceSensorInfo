package com.example.device_sensor_info

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.hardware.camera2.CameraManager



class MainActivity : FlutterActivity() {

    private val CHANNEL = "device_info_channel"
    private var isFlashOn = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    val deviceInfo = mapOf(
                        "deviceName" to Build.MODEL,
                        "osVersion" to Build.VERSION.RELEASE
                    )
                    result.success(deviceInfo)
                }

                "getBatteryLevel" -> {
                    val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                    val battery = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                    result.success(battery)
                }

                "toggleFlashlight" -> {
                    val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
                    try {
                        val cameraId = cameraManager.cameraIdList[0]
                        isFlashOn = !isFlashOn
                        cameraManager.setTorchMode(cameraId, isFlashOn)
                        result.success(isFlashOn)
                    } catch (e: Exception) {
                        result.error("FLASH_ERROR", "Failed to toggle flashlight: ${e.message}", null)
                    }
                    result.success(null)
                }

                "getGyroscopeData" -> {
                    val sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                    val gyroscope = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
                    val listener = object : SensorEventListener {
                        override fun onSensorChanged(event: SensorEvent?) {
                            event?.let {
                                val gyroData = mapOf(
                                    "x" to it.values[0],
                                    "y" to it.values[1],
                                    "z" to it.values[2]
                                )
                                result.success(gyroData)
                                sensorManager.unregisterListener(this)
                            }
                        }
                        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
                    }
                    sensorManager.registerListener(listener, gyroscope, SensorManager.SENSOR_DELAY_NORMAL)
                }

                else -> result.notImplemented()
            }
        }
    }
}
