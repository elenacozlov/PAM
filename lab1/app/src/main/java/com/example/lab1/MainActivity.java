package com.example.lab1;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.SearchManager;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;

public class MainActivity extends AppCompatActivity {
    private static final String CHANNEL_ID = "channel_id01";
    private static final int NOTIFICATION_ID = 1;

    EditText editText;
    Button btnSearch;

    private static final int REQUEST_IMAGE_CAPTURE = 1;

    public void onRadioButtonClicked(View view) {
        // Is the button now checked?
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        editText = findViewById(R.id.editText);
        btnSearch = findViewById(R.id.button2);
        btnSearch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent searchIntent = new Intent(Intent.ACTION_WEB_SEARCH);
                String term = editText.getText().toString();
                searchIntent.putExtra(SearchManager.QUERY, term);
                startActivity(searchIntent);
            }
        });


        Button ButtonForNotification = findViewById(R.id.button);
        ButtonForNotification.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showNotification();
            }
        });

        Button openCamera = findViewById(R.id.button3);

        openCamera.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    // check if radio button is checked
                    RadioGroup radioGroup = findViewById(R.id.radioGroup);
                    int selectedId = radioGroup.getCheckedRadioButtonId();
                    switch (selectedId) {
                        case R.id.takePicture:
                            Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                            startActivityForResult(intent, REQUEST_IMAGE_CAPTURE);
                            break;
                        case R.id.showNotification:
                            showNotification();
                            break;
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

    //capture camera image
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_IMAGE_CAPTURE) {
            Bitmap photo = (Bitmap) data.getExtras().get("data");
            Intent sendImage = new Intent(MainActivity.this, ImageViewActivity.class);
            sendImage.putExtra("image", photo);
            startActivity(sendImage);
        }
    }

    private void showNotification() {

        createNotificationChannel();

        NotificationCompat.Builder builder = new NotificationCompat.Builder(, CHANNEL_ID);
        builder.setSmallIcon(R.drawable.ic_notif);
        builder.setContentTitle("i am notification");
        builder.setContentText("hello");
        builder.setTimeoutAfter(10000);

        //notification manager
        NotificationManagerCompat notificationManagerCompat = NotificationManagerCompat.from(this);
        notificationManagerCompat.notify(NOTIFICATION_ID, builder.build());
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            //swipe notifications
            CharSequence name = "My Notification";
            String description = "My notification description";
            //importance of clicking
            int importance = NotificationManager.IMPORTANCE_DEFAULT;

            NotificationChannel notificationChannel = new NotificationChannel(CHANNEL_ID, name, importance);
            notificationChannel.setDescription(description);

            NotificationManager notificationManager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);

            notificationManager.createNotificationChannel(notificationChannel);
        }
    }


}