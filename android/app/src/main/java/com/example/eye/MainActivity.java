package com.example.eye;

import android.Manifest;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.util.Log;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.mantra.mis100.IrisData;
import com.mantra.mis100.MIS100;
import com.mantra.mis100.MIS100Event;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;
public class MainActivity extends FlutterActivity implements MIS100Event {

    ImageView imgIris;
    EditText edtQuality;
    EditText edtTimeOut;

    private enum ScannerAction {
        Capture
    }

    byte[] Enroll_Template;
    ScannerAction scannerAction = ScannerAction.Capture;

    MIS100 mis100;
    byte[] _bitmap;

    private static boolean isCaptureRunning = false;
    public static final String PERMISSION_WRITE_STORAGE = Manifest.permission.WRITE_EXTERNAL_STORAGE;
    public static final String PERMISSION_READ_STORAGE = Manifest.permission.READ_EXTERNAL_STORAGE;
//    public static final String MANAGE_EXTERNAL_STORAGE = Manifest.permission.MANAGE_EXTERNAL_STORAGE;

    public static String[] Permission = new String[] { PERMISSION_WRITE_STORAGE, PERMISSION_READ_STORAGE };

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestPermissions(Permission, 1);

        String CHANNEL = "irisChannel";
        new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    switch (methodCall.method) {
                        case "init":
                            String info = InitScanner();
                            result.success(info);
                            break;
                        case "getDeviceInfo":
                             info = "Serial: " + mis100.GetDeviceInfo().SerialNo()
                                    + " Make: " + mis100.GetDeviceInfo().Make()
                                    + " Model: " + mis100.GetDeviceInfo().Model()
                                    + "\nCertificate: " + mis100.GetCertification()
                                    + "\nSDK Version: " + mis100.GetSDKVersion();
                            result.success(info);
                            break;
                        case "startScan":
                            if (!isCaptureRunning) {
                                 StartSyncCapture(result);
//                                    result.success(_bitmap);
                            }else{
                                StopCapture(result);
                            }
                            break;
                        case "stopScan":
                            if (isCaptureRunning) {
                                StopCapture(result);
                            }
                            break;
                        case "unInit":
                            UnInitScanner();
                            break;
                    }

//                        result.success("success");
                });

//
//          try {
//         File file = new File(Environment.getExternalStorageDirectory() + "/MIS100/");
//          if (!file.exists()) {
//          //noinspection ResultOfMethodCallIgnored
//          file.mkdirs();
//          }
//          } catch (Exception ignored) {
//          }
//
//        // FindFormControls();
//        try {
//            this.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
//        } catch (Exception e) {
//            Log.e("Error", e.toString());
//        }
    }

    @Override
    public void onConfigurationChanged(@NonNull Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
/*
         setContentView(R.layout.activity_mis100_sample);
         FindFormControls();
*/

        if (isCaptureRunning) {
            if (mis100 != null) {
                mis100.StopAutoCapture();
            }
        }
        Handler handler = new Handler();
        handler.postDelayed(() -> {
            if (mis100 == null) {
                mis100 = new MIS100(MainActivity.this);
                 mis100.SetApplicationContext(MainActivity.this);
            } else {
                InitScanner();
            }

        }, 2000);

    }

    @Override
    protected void onStart() {
        if (mis100 == null) {
            mis100 = new MIS100(this);
             mis100.SetApplicationContext(MainActivity.this);
        } else {
            InitScanner();
        }
        super.onStart();
    }

    protected void onStop() {
        UnInitScanner();
        super.onStop();
    }

    @Override
    protected void onDestroy() {
        if (mis100 != null) {
            mis100.Dispose();
        }
        super.onDestroy();
    }

    // public void FindFormControls() {
    // btnInit = (Button) findViewById(R.id.btnInit);
    // btnUninit = (Button) findViewById(R.id.btnUninit);
    // btnClearLog = (Button) findViewById(R.id.btnClearLog);
    // lblMessage = (TextView) findViewById(R.id.lblMessage);
    // txtEventLog = (EditText) findViewById(R.id.txtEventLog);
    // imgIris = (ImageView) findViewById(R.id.imgIris);
    // btnSyncCapture = (Button) findViewById(R.id.btnSyncCapture);
    // btnStopCapture = (Button) findViewById(R.id.btnStopCapture);
    // edtQuality = (EditText) findViewById(R.id.edtQuality);
    // edtTimeOut = (EditText) findViewById(R.id.edtTimeOut);
    // }

    // public void onControlClicked(View v) {
    //
    // switch (v.getId()) {
    // case R.id.btnInit:
    // InitScanner();
    // break;
    // case R.id.btnUninit:
    // UnInitScanner();
    // break;
    // case R.id.btnSyncCapture:
    // scannerAction = ScannerAction.Capture;
    // if (!isCaptureRunning) {
    // StartSyncCapture();
    // }
    // break;
    // case R.id.btnStopCapture:
    // StopCapture();
    // break;
    // case R.id.btnClearLog:
    // ClearLog();
    // break;
    // default:
    // break;
    // }
    // }

    private String InitScanner() {
        try {
            int ret = mis100.Init();
            System.out.print(ret);
            if (ret != 0) {
                Toast.makeText(this, ret,
                        Toast.LENGTH_LONG).show();
                // SetTextOnUIThread(mis100.GetErrorMsg(ret));
            } else {
//                showSuccessLog();
                // SetTextOnUIThread("Init success");
                //                result.success(info);
                return "Serial: " + mis100.GetDeviceInfo().SerialNo()
                        + " Make: " + mis100.GetDeviceInfo().Make()
                        + " Model: " + mis100.GetDeviceInfo().Model()
                        + "\nCertificate: " + mis100.GetCertification()
                        + "\nSDK Version: " + mis100.GetSDKVersion();
                // SetLogOnUIThread(info);
//                Toast.makeText(this, info,
//                        Toast.LENGTH_LONG).show();
            }
        } catch (Exception ex) {
            Toast.makeText(this, ex.getLocalizedMessage(),
                    Toast.LENGTH_LONG).show();
            // SetTextOnUIThread("Init failed, unhandled exception");
        }
         return "info";
    }

    private void StartSyncCapture(Result result) {
        new Thread(() -> {
//                SetTextOnUIThread("");
            isCaptureRunning = true;
            try {
                IrisData irisData = new IrisData();
                int quality = 40;
                try {
                    quality = Integer.parseInt(edtQuality.getText().toString());
                } catch (Exception e) {
//                    result.error("400",e.toString(),"quality error");
//                        Toast.makeText(this, e.toString(),Toast.LENGTH_LONG).show();
                }
                int timeout = 20000;
                try {
                    timeout = Integer.parseInt(edtTimeOut.getText().toString());
                } catch (Exception e) {
//                    result.error("401",e.toString(),"timeout error");
                }
                int ret = mis100.AutoCapture(irisData, quality, timeout);
                if (ret != 0) {
//                    result.error("402",mis100.GetErrorMsg(ret),"timeout error");
//                        SetTextOnUIThread(mis100.GetErrorMsg(ret));
                } else {
//                    final Bitmap bitmap = BitmapFactory.decodeByteArray(irisData.K7Image(), 0,
//                            irisData.K7Image().length);
                    _bitmap = irisData.IRISImage();
                    result.success(_bitmap);
//                        DisplayIris(bitmap);

                    String log = "\nCapture Success"
                            + "\nQuality :: " + irisData.Quality()
                            + "\nK7ImageLength :: " + irisData.K7Image().length
                            + "\nK7 Width :: " + irisData.K7ImageWidth()
                            + "\nK7 Height :: " + irisData.K7ImageHeight();
//                        SetLogOnUIThread(log);
                    System.out.print(log);
//if(ContextCompat.checkSelfPermission() =='')
//                        if (ContextCompat.checkSelfPermission(
//                                getContext(), Manifest.permission.MANAGE_EXTERNAL_STORAGE) ==
//                                PackageManager.PERMISSION_GRANTED) {
//                            // You can use the API that requires the permission.
//                            SetData2(irisData);
//                        }else {
//                            requestPermissions(Permission, 1);
//                        }
                    SetData2(irisData);
                }
            } catch (Exception ex) {
                result.error("500",ex.toString(),"Exception");
                ex.printStackTrace();
//                    SetTextOnUIThread("Error");
            } finally {
                isCaptureRunning = false;
            }
        }).start();
//        return  _bitmap;
    }

    private void StopCapture(Result result) {
        try {
            mis100.StopAutoCapture();
            isCaptureRunning = false;
            result.success("capture stopped");
        } catch (Exception e) {
//            SetTextOnUIThread("Error");
            result.error("400","can not stopped scanning","try again...");
        }
    }

    private void UnInitScanner() {
        if (mis100 != null)
             isCaptureRunning=true;
            try {
                assert mis100 != null;
                int ret = mis100.UnInit();
                Toast.makeText(this, ret,
                        Toast.LENGTH_LONG).show();
                if (ret != 0) {
                    Toast.makeText(this, "error",
                            Toast.LENGTH_LONG).show();
//                    SetTextOnUIThread(mis100.GetErrorMsg(ret));
                } else {
                    Toast.makeText(this, "Uninit Success",
                            Toast.LENGTH_LONG).show();
//                    SetLogOnUIThread("Uninit Success");
//                    SetTextOnUIThread("Uninit Success");
                }
            } catch (Exception e) {
                Log.e("UnInitScanner.EX", e.toString());
            }
    }

//    private void DisplayIris(final Bitmap bitmap) {
//        imgIris.post(new Runnable() {
//            @Override
//            public void run() {
//                imgIris.setImageBitmap(bitmap);
//            }
//        });
//    }

    private void WriteFile(String filename, byte[] bytes) {
        try {
            String path = Environment.getExternalStorageDirectory()
                    + "//IrisData";
            File file = new File(path);
            if (!file.exists()) {
                boolean isWriteSuccess = file.mkdirs();
//                Toast.makeText(this, Boolean.toString(isWriteSuccess) ,Toast.LENGTH_LONG).show();
            }
            path = path + "//" + filename;
            file = new File(path);
            if (!file.exists()) {
                boolean isCreatedNewFile = file.createNewFile();
//                Toast.makeText(this, Boolean.toString(isCreatedNewFile) ,Toast.LENGTH_LONG).show();
            }
            FileOutputStream stream = new FileOutputStream(path);
            stream.write(bytes);
            stream.close();
        } catch (Exception e1) {
            e1.printStackTrace();
        }
    }

    public void SetData2(IrisData irisData) {
        if (scannerAction.equals(ScannerAction.Capture)) {
            Enroll_Template = new byte[irisData.ISOTemplate().length];
            System.arraycopy(irisData.ISOTemplate(), 0, Enroll_Template, 0,
                    irisData.ISOTemplate().length);
        }

        WriteFile("Raw.raw", irisData.RawData());
        WriteFile("K7.bmp", irisData.K7Image());
        WriteFile("Iris.bmp", irisData.IRISImage());
        WriteFile("ISOTemplate.iso", irisData.ISOTemplate());
    }

    @Override
    public void OnDeviceAttached(final int vid, final int pid, boolean hasPermission) {
        if (!hasPermission) {
            Toast.makeText(this, "Permission denied" ,Toast.LENGTH_LONG).show();
//            SetTextOnUIThread("Permission denied");
            return;
        }
        new Thread(() -> {
            if (vid == 11279 && pid == 8448) {
                InitScanner();
            }
        }).start();
    }

//    private void showSuccessLog() {
//        Toast.makeText(this, "device attached",
//                Toast.LENGTH_LONG).show();
////        SetTextOnUIThread("Init success");
//        String info = "Serial: "
//                + mis100.GetDeviceInfo().SerialNo() + "\nMake: "
//                + mis100.GetDeviceInfo().Make() + "\nModel: "
//                + mis100.GetDeviceInfo().Model() + "\nWidth: "
//                + mis100.GetDeviceInfo().Width() + "\nHeight: "
//                + mis100.GetDeviceInfo().Height()
//                + "\nCertificate: " + mis100.GetCertification();
////        SetLogOnUIThread(info);
//    }

    @Override
    public void OnDeviceDetached() {
        UnInitScanner();
//        SetTextOnUIThread("Device removed");
    }

    @Override
    public void OnHostCheckFailed(String err) {
        try {
//            SetLogOnUIThread(err);
            Toast.makeText(this, err, Toast.LENGTH_LONG).show();
        } catch (Exception ignored) {
        }
    }

    @Override
    public void OnMIS100AutoCaptureCallback(int ErrorCode, int Quality, byte[] irisImage) {
        if (ErrorCode != 0) {
//            SetTextOnUIThread("Err :: " + ErrorCode + " (" + mis100.GetErrorMsg(ErrorCode) + ")");
            return;
        }
//        SetTextOnUIThread("Quality :: " + Quality);
        final Bitmap bmp = BitmapFactory.decodeByteArray(irisImage, 0, irisImage.length);
        imgIris.post(() -> imgIris.setImageBitmap(bmp));
    }
}
