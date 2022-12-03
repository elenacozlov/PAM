package com.example.lab1;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.ImageView;

public class ImageViewActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.imageview);

        Intent intent = getIntent();
        ImageView imageView = findViewById(R.id.imageView);
        imageView.setImageBitmap(intent.getParcelableExtra("image"));
    }
}