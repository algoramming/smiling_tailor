# Smiling Tailor

Welcome to our tailor-centric Custom Business Management System, where the dynamic fusion of ERP (Enterprise Resource Planning) and CRM (Customer Relationship Management) empowers your tailoring business like never before. Our feature-rich and user-friendly application has been meticulously crafted to streamline your operations effortlessly. With our cutting-edge system, you can easily manage and monitor essential elements of your business, including managers, vendors, inventory, and employees. Effortlessly process orders and witness the seamless flow of transaction history in real-time, ensuring airtight organization, enhanced efficiency, and complete control over your business processes. We take pride in presenting this exceptional software solution, developed in-house by our skilled team at Algoramming. Our commitment to quality and reliability ensures that every aspect of our system is fine-tuned to meet the specific needs of your tailoring business, setting you on a path to success with unparalleled ease.

- Youtube Sample Video Link: https://youtu.be/aL9WJdhVHkY

![Sample Image](smiling-tailor.png)

![Sample GIF](smiling-tailor.gif)


- `pocketbase update`

- `pocketbase --version`

- `pocketbase serve --http="0.0.0.0:4200"`

- `pocketbase serve`

- `pocketbase serve --debug`

- `smtp.gmail.com`

- `587`

- `algoramming`

- `livaxjtklqzksmid`

- `Set-Location -Path 'C:\src\pocketbase'; .\pocketbase serve --http="0.0.0.0:4200"` - for windows powershell

- `Set-Location -Path 'C:\src\pocketbase'; .\pocketbase serve` - for windows powershell

- `cd C:\src\pocketbase && pocketbase serve --http="0.0.0.0:4200"` - for windows cmd

- `cd C:\src\pocketbase && pocketbase serve` - for windows cmd


## Github Token

- `SmilingTailor` - `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`

## Firebase Token

- `FIREBASE_TOKEN` - `1//0gqSin8OD8zwOCgYIARAAGBASNwF-L9Irug3JGe54hfMbxFW5IobsW7VrY_TIgJaNADVkn30cD752GreR8x4jvQvIyJ4RIHHkAFI`


## Live Urls

- https://smilingtailor.algoramming.com

- https://www.smilingtailor.algoramming.com

- https://smilingtailor-algoramming.web.app

- https://smilingtailor-algoramming.firebaseapp.com

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


## Deploy Pocketbase on `fly.io` [Windows] 

- https://github.com/pocketbase/pocketbase/discussions/537

- https://youtu.be/fKCzn_91NTc

- https://indrazm.notion.site/Deploying-Pocketbase-to-Fly-io-08fa22f74e504180b77e6b36cc6f5f2b
