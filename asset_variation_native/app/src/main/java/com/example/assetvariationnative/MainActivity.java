package com.example.assetvariationnative;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;


public class MainActivity extends AppCompatActivity {
    private FlutterEngine flutterEngine;
    private Button chart, table;
    private Context context;

    static String  FLUTTER_ENGINE_ID = "asset_variation_flutter_module";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        context = this.getApplicationContext();;


        flutterEngine = new  FlutterEngine(this);
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );

        FlutterEngineCache
                .getInstance()
                .put(FLUTTER_ENGINE_ID, flutterEngine);

        chart = (Button) findViewById(R.id.chartAction);
        table = (Button) findViewById(R.id.tableAction);


        chart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (flutterEngine != null) {
                    flutterEngine.getNavigationChannel().pushRoute("asset?viewType=chart");
                }
                startActivity(
                        FlutterActivity
                                .withCachedEngine(FLUTTER_ENGINE_ID)
                                .build(context)
                );
            }
        });

        table.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (flutterEngine != null) {
                    flutterEngine.getNavigationChannel().pushRoute("asset?viewType=table");
                }
                startActivity(
                        FlutterActivity
                                .withCachedEngine(FLUTTER_ENGINE_ID)
                                .build(context)
                );
            }
        });


    }
}