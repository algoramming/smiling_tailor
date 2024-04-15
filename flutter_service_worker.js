'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "afc4b6fc77c35a50bbda218cbdb89cf7",
"splash/img/light-2x.png": "7777ee1b6c56d5de543af07b25a4c74b",
"splash/img/dark-4x.png": "398d2138abf02187259e8856f4749c44",
"splash/img/light-3x.png": "16ac09dc1ee4cea3d6a4507e0d4d9d66",
"splash/img/dark-3x.png": "16ac09dc1ee4cea3d6a4507e0d4d9d66",
"splash/img/light-4x.png": "398d2138abf02187259e8856f4749c44",
"splash/img/dark-2x.png": "7777ee1b6c56d5de543af07b25a4c74b",
"splash/img/dark-1x.png": "ff10756dc043de685917610c4168b50c",
"splash/img/light-1x.png": "ff10756dc043de685917610c4168b50c",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/style.css": "c94c38ff00a9d487c353a2d78989ea08",
"index.html": "c1861e0e1baf97343ad5b5a74303ef29",
"/": "c1861e0e1baf97343ad5b5a74303ef29",
"main.dart.js": "17b006a9b912995361fb04ec3a2ec7aa",
"404.html": "349a062356638e68797b6235741f2aca",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "f30e5f96af69cd0bc6e9ce18285fe9a5",
"icons/Icon-192.png": "857ba3bafa0b09c5f5ad80c3604ba475",
"icons/Icon-maskable-192.png": "857ba3bafa0b09c5f5ad80c3604ba475",
"icons/Icon-maskable-512.png": "bdc8f51da673cb28517756d271bde22d",
"icons/Icon-512.png": "bdc8f51da673cb28517756d271bde22d",
"manifest.json": "341d819db25b5d9f294c5d7497f23c5e",
"assets/AssetManifest.json": "ba3880a3968eec05cd0efa7a1cf2038d",
"assets/NOTICES": "359025bf2ccd3d01d10a546b5683544f",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "c92d156c2f319e3f4b0d1b2dde249efa",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "9826f64405449b5895cef474a2cf8fea",
"assets/fonts/MaterialIcons-Regular.otf": "266495305cd7e4d1f94337b878889a2d",
"assets/assets/riv/dash_flutter_muscot.riv": "d0802f9a79fb2e387c86d44ce2bc2110",
"assets/assets/types/warning.svg": "cfcc5fcb570129febe890f2e117615e0",
"assets/assets/types/back.svg": "ba1c3aebba280f23f5509bd42dab958d",
"assets/assets/types/bubbles.svg": "1df6817bf509ee4e615fe821bc6dabd9",
"assets/assets/types/failure.svg": "cb9e759ee55687836e9c1f20480dd9c8",
"assets/assets/types/success.svg": "6e273a8f41cd45839b2e3a36747189ac",
"assets/assets/types/help.svg": "7fb350b5c30bde7deeb3160f591461ff",
"assets/assets/gifs/loading.gif": "33192692397832c47472188c4d1d571d",
"assets/assets/svgs/transfer.svg": "ed295c991c6d5a6dbcba6a9bd8bc02f3",
"assets/assets/svgs/db-view.svg": "49e6687298c0e2840e12bde1269b901f",
"assets/assets/svgs/no-data.svg": "c6745bc355cb510fe47a6fb34bbd5be3",
"assets/assets/svgs/customer-copy.svg": "58447747b70ca1568a8c77fba0c04be9",
"assets/assets/svgs/time-format.svg": "a1de37e1878a227fdc07c87ce875818f",
"assets/assets/svgs/chart.svg": "0cae38ba469fd228df6424251b2c1d60",
"assets/assets/svgs/access-denied.svg": "61aecf89d7cdfef7c9c458ef718487db",
"assets/assets/svgs/camera-retro.svg": "1283080deabad806a89382603c7c31f1",
"assets/assets/svgs/cashier-copy.svg": "d722d9b1aaf75c90ee8bd2880c57d6a1",
"assets/assets/svgs/home.svg": "b6c22b606f4dfcb7df439c29ea2f72ce",
"assets/assets/svgs/performance-overlay.svg": "294f6d406946357f6127baeba4452423",
"assets/assets/svgs/theme.svg": "9b35dd33f49477dad226127585d97921",
"assets/assets/svgs/date-format.svg": "1a9369958867ecd2013bbf6fc430e204",
"assets/assets/svgs/out-for-delivery.svg": "2581bf65d1733fa2121ef3246dba372f",
"assets/assets/svgs/vendor.svg": "0a85b7fd6f349372ef9587509c13b898",
"assets/assets/svgs/qr-code.svg": "7a59234e9798d573ede82aa30bb57a93",
"assets/assets/svgs/inventory.svg": "d85fdbd8bcc90603df844dc10579451e",
"assets/assets/svgs/server-error-old.svg": "404f42f1239a7ba19244afd1740e3f92",
"assets/assets/svgs/order.svg": "cca6bedb5efb7a7353baf7e80a8d7bfc",
"assets/assets/svgs/pending-delivery.svg": "e20c5068e78d4d9a1c719e93f7e84ef6",
"assets/assets/svgs/settings.svg": "1524352e53f3fa9cf67a154a869836ba",
"assets/assets/svgs/pie_chart.svg": "e1a3498a39f52e33c35700bed73f6737",
"assets/assets/svgs/ready-for-delivery.svg": "941c0480bea8bdc6ca7d29fc0b4640fc",
"assets/assets/svgs/wallet.svg": "f883f89cc2489eb7a65fac44898045dc",
"assets/assets/svgs/dashboard.svg": "12ed4ad43997c865d74379505543a6c3",
"assets/assets/svgs/transaction.svg": "022a278273de881f8b2367d2f379ae56",
"assets/assets/svgs/left-arrow.svg": "c7c597de06e8d589a6e2a77bbf6101b3",
"assets/assets/svgs/check.svg": "2696767b65235e2777e81b834a702974",
"assets/assets/svgs/currency-format.svg": "8e1d4d0468543572a136288b69391896",
"assets/assets/svgs/maintenance.svg": "ac042119d58ca21f9892c8362a85a621",
"assets/assets/svgs/slip-format.svg": "535d1f69ddd4b3d29781ee6d0bb9be04",
"assets/assets/svgs/tailor-copy.svg": "27f1b45334df33d779c06b23d84efd56",
"assets/assets/svgs/server-error.svg": "1056a26fc9975a4ffb7cd59e38f936f1",
"assets/assets/svgs/thumbs-up.svg": "186641711272d840823935ac2d3d7b97",
"assets/assets/svgs/notification.svg": "da6ea5f9f09d4d9c1ed8750f3436291e",
"assets/assets/svgs/external-link-symbol.svg": "163768490dc7a1a1b9ceb00912e78d36",
"assets/assets/svgs/about.svg": "a4478570d6bd67a90dd152b7ea5998c1",
"assets/assets/svgs/trash.svg": "2e2cad19c23737d70c5ad33e5d4db1c3",
"assets/assets/svgs/check-box-empty.svg": "962a8eaea47c9bfa05751f75b3722a08",
"assets/assets/svgs/pdf-format.svg": "098f1052241d958d24d6fa6d386b196a",
"assets/assets/svgs/sun.svg": "0e47d4dbfe668225075d8d3aed956102",
"assets/assets/svgs/url-config.svg": "ef396a82ace3ea29a1101d3ecdcbcf2c",
"assets/assets/svgs/about-us.svg": "8ad3d95965bddd5d3f5ec2450b07fe5e",
"assets/assets/svgs/signout.svg": "0aab0389cd4407d0988580ffa41b7c58",
"assets/assets/svgs/language.svg": "f9652ea406e621deca211b56103765d6",
"assets/assets/svgs/delete.svg": "3bee4350c0535955b4be8b66388a0a38",
"assets/assets/svgs/three_dot.svg": "3865272b4c244340c393af4815204fd4",
"assets/assets/svgs/restore.svg": "4152454fb6104c96461883b4b76b60cb",
"assets/assets/svgs/currency.svg": "7fe257b68bb5ed5009c51ee7b7ebf428",
"assets/assets/svgs/profile.svg": "98b9a8870a7ff33847d70e7efedbc71b",
"assets/assets/svgs/filter.svg": "5b793ae4074399c5b00d71c30cdf62cb",
"assets/assets/svgs/error.svg": "0d3b239081cfb9d02edfa87766f33399",
"assets/assets/svgs/invoice.svg": "a5b91fa7dfa851f9f5e9b3882f531423",
"assets/assets/svgs/employee.svg": "3f30bef8a0e928b5a4a08ba9f0abfe58",
"assets/assets/svgs/company.svg": "c14bc7f8ee0a9edb366f811cc1afe478",
"assets/assets/svgs/menu.svg": "38edd1f6ae4971b305aec504a3096bf8",
"assets/assets/svgs/under-processing.svg": "d4e0e58b46a323d2b0dcb37ec672f2ce",
"assets/assets/svgs/completed.svg": "3495668510842cd9097776c7db2cd607",
"assets/assets/svgs/link-symbol.svg": "ae1a7ace6b9700305fba6fc4bf2b021a",
"assets/assets/svgs/moon.svg": "cc1f0808b25203676b7e9cc3407fb148",
"assets/assets/svgs/font.svg": "b8eb02bae64341dc631554558051eca4",
"assets/assets/json/currency_data.json": "70db8b143bf2853b2dcc25fe332d04f4",
"assets/assets/json/measurement_data.json": "91c3c020870c2acbabac08f94d0d78ae",
"assets/assets/icons/splash-icon-384x384.png": "aefb02e9c1f488479629c7a28951bcc5",
"assets/assets/icons/app-icon-1024x1024.png": "7527516cbaf4ae939cd8835fd5d3a910",
"assets/assets/icons/loading-front-part.png": "13ce4762b601218044a375ea6d3de614",
"assets/assets/icons/loading-back-part.png": "ecf47783720b28f649bf9294f2734eae",
"assets/assets/files/sample.json": "1a0262159cdbaa8ea9df4f6ba9bd1ac6",
"assets/assets/fonts/NotoSansBengali-Regular.ttf": "46a8082f707c565d16b1a112e21e447e",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
