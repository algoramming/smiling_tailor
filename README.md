# smiling_tailor

A new Flutter project.


- `pocketbase serve --http="0.0.0.0:4200"`

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)


## msix generate instructions

- Go to pubspec.yaml file and add msix package. Then add those lines at the end of the `dev_dependencies` section:

```
    msix_config:
        display_name: Smiling Tailor
        publisher_display_name: Alogoramming
        identity_name: com.algoramming.smilingtailor
        msix_version: 1.0.0.0
        logo_path: D:\Algoramming\Flutter-Projects\smiling_tailor\assets\icons\app-icon-1024x1024.png
```

- Run this command: `dart run msix:create`
- msix file will be generate in the `build/windows/runner/Release/` folder.
- Now you can share this msix file to any pc to install the app.


## msix install instructions

- Right click on the msix file and click on properties.
- Go to `Digital Signatures` tab, select the `Msix Testing` and click on `Details` button.
- Click on `View Certificate` button.
- Click on `Install Certificate` button.
- Select `Local Machine` and click on `Next` button.
- Select `Place all certificates in the following store` and click on `Browse` button.
- Select `Trusted Root Certification Authorities` and click on `OK` button.
- Click on `Next` button.
- Click on `Finish` button.
- Now you can install the msix file.


## msix generate with appinstaller instructions

- Go to pubspec.yaml file and add msix package. Then add those lines at the end of the `dev_dependencies` section:

```
    msix_config:
        display_name: Smiling Tailor
        app_installer: #<-- app installer configuration
            publish_folder_path: D:\Algoramming\Flutter-Projects\smiling_tailor\publish
            hours_between_update_checks: 0
            automatic_background_task: true
            update_blocks_activation: true
            show_prompt: true
            force_update_from_any_version: false
        publisher_display_name: Alogoramming
        identity_name: com.algoramming.smilingtailor
        msix_version: 1.0.0.0
        logo_path: D:\Algoramming\Flutter-Projects\smiling_tailor\assets\icons\app-icon-1024x1024.png
```

- Run this command: `dart run msix:publish`
- msix files `[all versions of msix file, smilingtailor.appinstaller, index.html]` will be generate in the `publish` folder.
- Go to `publish\index.html` file and at the bottom you will find a javascript function named `function download()`
- Just simply change the 2nd line of the function from `a.href = '/smilingtailor.appinstaller';` to `a.href = 'smilingtailor.appinstaller';`
- Go to `publish` folder by `cd publish` and run this command: `python -m http.server 1010`
- Now go to your router ip address with port 8000. For example: `192.168.10.101:1010`. For my case: `http://103.113.227.244:1010/`
- Through this url `http://192.168.10.101:1010/` you can download the msix appinstaller file and also share this url to any pc to install the app under same network.


## msix install instructions

- You need to install the certificate at first. Follow the `msix install instructions` section.
- Now you can install the msix appinstaller file.