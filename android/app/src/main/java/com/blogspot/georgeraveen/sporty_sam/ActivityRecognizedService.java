package com.blogspot.georgeraveen.sporty_sam;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.JobIntentService;

import com.google.android.gms.location.ActivityRecognitionResult;
import com.google.android.gms.location.DetectedActivity;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.sql.Timestamp;

public class ActivityRecognizedService extends JobIntentService {

    static void enqueueWork(Context context, Intent work) {
        enqueueWork(context, ActivityRecognizedService.class, 1, work);
    }

    @Override
    public int onStartCommand(@Nullable Intent intent, int flags, int startId) {
        return super.onStartCommand(intent, flags, startId);
    }

    // This method is called when service starts instead of onHandleIntent
    protected void onHandleWork(@Nullable Intent intent) {
        onHandleIntent(intent);
    }

    // remove override and make onHandleIntent private.
    private void onHandleIntent(@Nullable Intent intent) {
        ActivityRecognitionResult result = ActivityRecognitionResult.extractResult(intent);
        List<DetectedActivity> activities = result.getProbableActivities();

        DetectedActivity mostLikely = activities.get(0);

        for (DetectedActivity a : activities) {
            if (a.getConfidence() > mostLikely.getConfidence()) {
                mostLikely = a;
            }
        }

        String type = getActivityString(mostLikely.getType());
        int confidence = mostLikely.getConfidence();

        String data = type + "," + confidence;

        Log.d("onHandleIntent", data);

        // Same preferences as in ActivityRecognitionFlutterPlugin.java
        SharedPreferences preferences =
                getApplicationContext().getSharedPreferences(
                        MainActivity.ACTIVITY_RECOGNITION, MODE_PRIVATE);

        preferences.edit().clear()
                .putString(
                        MainActivity.DETECTED_ACTIVITY,
                        data
                )
                .apply();
        try {
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            String dataToWrite = timestamp.toString() + ","+data+"\n";
            FileOutputStream fos = openFileOutput("example2.txt",MODE_APPEND);
            fos.write(dataToWrite.getBytes());
            fos.close();
        }
        catch (FileNotFoundException e){
            e.printStackTrace();
        }
        catch (IOException e){
            e.printStackTrace();
        }

        /* 
        TODO - Decide how to update remote server from native code here
        Options:
            * Initialize Firebase here natively and make the update here (This can
            even completely replace sending Firebase requests from Flutter side)
            
            * Store updates to a JSON/SQLite and try to access it from flutter side.
            And then push to the Firebase.
        */

    }

    public static String getActivityString(int type) {
        if (type == DetectedActivity.IN_VEHICLE) return "IN_VEHICLE";
        if (type == DetectedActivity.ON_BICYCLE) return "ON_BICYCLE";
        if (type == DetectedActivity.ON_FOOT) return "ON_FOOT";
        if (type == DetectedActivity.RUNNING) return "RUNNING";
        if (type == DetectedActivity.STILL) return "STILL";
        if (type == DetectedActivity.TILTING) return "TILTING";
        if (type == DetectedActivity.WALKING) return "WALKING";

        // Default case
        return "UNKNOWN";
    }
}

