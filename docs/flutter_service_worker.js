'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "36d846550e14da2fd708812ab89aedb5",
"assets/AssetManifest.bin.json": "eaadfccd723e118e1e9bdb88ed1bbf30",
"assets/AssetManifest.json": "318b4fed8bb89c60df59ea037f677583",
"assets/assets/data/capitulo01/nivel_sumas_resta.json": "3fc8c705dc91aab2eb347536f3241216",
"assets/assets/data/capitulo02/nivel_tablas_multiplicar.json": "ce37feb23c209052cb5c9abfce109b8d",
"assets/assets/icons/energy_0.png": "72799050d5210dc42439288ceae614a9",
"assets/assets/icons/energy_1.png": "dae34b59d5b4456597d5ed1da4de4740",
"assets/assets/icons/energy_10.png": "f1fb581f9fe81280e8104133c439e12f",
"assets/assets/icons/energy_2.png": "1b3169a2cd5393ee5b3dad9006e1d3ba",
"assets/assets/icons/energy_3.png": "e2be213a47fa3b6aaf789f38bdf6530d",
"assets/assets/icons/energy_4.png": "dbdc6c6ccc1a41cf56cae87347ea64e2",
"assets/assets/icons/energy_5.png": "cca64637c7f31abac500bf5a1781a580",
"assets/assets/icons/energy_6.png": "5bedac9f360aebbace80a91822782f6c",
"assets/assets/icons/energy_7.png": "528cd26a94b85825377ff3c43fbca2a7",
"assets/assets/icons/energy_8.png": "35edebc6b029fea905b89d6ea7a1d786",
"assets/assets/icons/energy_9.png": "1bff0d9454e9502b73b6829544aea1e5",
"assets/assets/icons/Estadisticas.png": "c82af2ce2df3ab0bf36adcdd74fcdd05",
"assets/assets/icons/gear.png": "bc5250af29ded96fb92f9dd6849ea0c7",
"assets/assets/icons/Inicio.png": "9539508e823ad49600f2c19d66e379bb",
"assets/assets/icons/nivel.png": "ed7fae7dc6d8f7f7d9dbc8dcd364d5b9",
"assets/assets/icons/Notificaciones.png": "008a4e5b2c98071e1854e7c7433e7d6b",
"assets/assets/icons/perfil.png": "004af1d2250ffa6b60c206c1fb2ba24e",
"assets/assets/icons/rayo_energia.png": "c129402421680ad42e62fa779c6f5778",
"assets/assets/icons/Recompensas.png": "7ee203187e7c804ccee3e4a27998f47d",
"assets/assets/images/apple_icon.png": "8d1392d3c9efb6cb2ea9dd9d9266f691",
"assets/assets/images/gamalytix_logo.png": "fe00e9d8ae391ad37c03f24fc120d068",
"assets/assets/images/google.png": "18ec3c5cd43e898fa3df840d202d4a98",
"assets/assets/images/logo-black.png": "c019bd434e5489eb40e386b60cf045c9",
"assets/assets/images/travel_paradise.png": "7fbd4105049438b1849f66869f24a159",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "d65d6c24f7d65a4b27d2d8011e569012",
"assets/NOTICES": "22df816f5255a5b42a3e5a76874d9460",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "47dfc6ae06f41723ac0d103c9cbf0233",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "35879cb98bfeaf1de65d619ae0a9994a",
"/": "35879cb98bfeaf1de65d619ae0a9994a",
"main.dart.js": "17cd263306585740c2e9236b876efc51",
"manifest.json": "2a6dfb96ce7624779849221791cbfcd9",
"version.json": "91db5bda29dec97c2cf10301b99abd1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
