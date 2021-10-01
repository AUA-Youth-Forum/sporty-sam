package com.blogspot.georgeraveen.sporty_sam;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class ActivityRecognizedBroadcastReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        ActivityRecognizedService.enqueueWork(context, intent);
    }
}
