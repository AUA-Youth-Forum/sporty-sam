package com.blogspot.georgeraveen.sporty_sam;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import java.util.HashMap;

import com.google.android.gms.location.ActivityRecognition;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;

@SuppressLint("LongLogTag")
public class MainActivity extends FlutterActivity implements EventChannel.StreamHandler, SharedPreferences.OnSharedPreferenceChangeListener {
    private EventChannel channel;
    private EventChannel.EventSink eventSink;

    public static final String DETECTED_ACTIVITY = "detected_activity";
    public static final String ACTIVITY_RECOGNITION = "activity_recognition_flutter";

    private final String TAG = "activity_recognition_flutter";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        channel = new EventChannel(flutterEngine.getDartExecutor(), ACTIVITY_RECOGNITION);
        channel.setStreamHandler(this);
    }

    @SuppressWarnings("unchecked")
    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        HashMap<String, Object> args = (HashMap<String, Object>) arguments;
        Log.d(TAG, "args: " + args);
        boolean fg = (boolean) args.get("foreground");
        startForegroundService();
        Log.d(TAG, "foreground: " + fg);

        eventSink = events;
        startActivityTracking();

        SharedPreferences prefs = this.getSharedPreferences(ACTIVITY_RECOGNITION, Context.MODE_PRIVATE);
        prefs.registerOnSharedPreferenceChangeListener(this);
    }

    @Override
    public void onCancel(Object arguments) {
        channel.setStreamHandler(null);

        SharedPreferences prefs = this.getSharedPreferences(ACTIVITY_RECOGNITION, Context.MODE_PRIVATE);
        prefs.unregisterOnSharedPreferenceChangeListener(this);
    }

    @Override
    public void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String key) {
        String result = sharedPreferences
                .getString(DETECTED_ACTIVITY, "error");
        Log.d("onSharedPreferenceChange", result);
        if (key!= null && key.equals(DETECTED_ACTIVITY)) {
            Log.d(TAG, "Detected activity: " + result);
            eventSink.success(result);
        }
    }

    private void startActivityTracking() {
        // Start the service
        Intent intent = new Intent(this, ActivityRecognizedBroadcastReceiver.class);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);

        // Frequency in milliseconds
        long frequency = 1 * 1000;
        Task<Void> task = ActivityRecognition.getClient(this)
                .requestActivityUpdates(frequency, pendingIntent);

        task.addOnSuccessListener(new OnSuccessListener<Void>() {
            @Override
            public void onSuccess(Void e) {
                Log.d(TAG, "ActivityRecognition: onSuccess");
            }
        });
        task.addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception e) {
                Log.d(TAG, "ActivityRecognition: onFailure");
            }
        });
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    void startForegroundService() {
        Log.d(TAG, "Starting Foreground Service");

        Intent intent = new Intent(this, ForegroundService.class);

        // Tell the service we want to start it
        intent.setAction("start");

        // Pass the notification title/text/icon to the service
        intent.putExtra("title", "MonsensoMonitor")
                .putExtra("text", "Monsenso Foreground Service")
                .putExtra("icon", R.drawable.common_full_open_on_phone)
                .putExtra("importance", 3)
                .putExtra("id", 10);

        // Start the service
        this.startForegroundService(intent);
    }
}

