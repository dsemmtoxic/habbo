# Teste33 — persistent hider controls, isolated floor and avatar cache

Base: the successful signed Teste32. Android version `2.32.1-t33`, AIR
`2.32.135`. The APK remains named `Habbo_2.32.0_LoginSSO_Teste33.apk` to
continue the existing distribution naming. The unchanged floor editor keeps
its T30 marker.

## Area Hider accessibility

`AreaHide30.hiddenFurniture` excludes all `conf_area_hide` variants as well
as `conf_invis_control`. This applies before evaluating any rectangle or
inverted/overlapping area, so one hider cannot hide itself or another hider.
Ordinary furniture and room geometry remain subject to the selected areas.
The independent Invisible Furniture Controller option still works: an opted-in
hider can be hidden by that controller and restored immediately by turning it
off. Area exclusions do not override this explicit setting.

## Isolated floor mistaken for a door

The saved native RoomMessageHandler accepted a tile with three void neighbors
as an entrance without requiring a fourth connected floor tile. An isolated
tile matches both door orientations. After parsing the room, the native code
raised that tile by the wall height to construct the entrance geometry, causing
the reported tall dark shape. The plane parser had a separate left-edge
entrance heuristic that could also select an island.

New `RoomGeometry33` requires an actual connected floor neighbor. Native
RoomMessageHandler `_-4IZ` checks this before accepting either the90-degree or
180-degree entrance. Native RoomPlaneParser `_-3Vo` now skips disconnected
islands and continues looking for a valid entrance. Both use valid floor
heights0..99 and reject void sentinels. Room packets, entry coordinates, avatar
movement logic, and the server layout are not modified.

## Avatar reload on reentry

The supplied13.466-second video shows already loaded furniture while many
avatars appear as gray silhouettes and progressively become visible. This
does not establish that the device redownloads every file over the network.
Native code provides the relevant path: RoomSessionManager ends a room and
calls AvatarRenderManager's purge, which invokes the download manager's purge.
The native renderer uses a gray placeholder when required figure libraries
are no longer ready.

The previous policy retained at most64 **libraries**, not64 avatars. A figure
depends on several libraries. It also released every optional avatar library
when AIR `System.totalMemory` exceeded384MiB. A second policy issue replaced
every touched library's timestamp with the same cleanup time, losing the true
recent-use ordering.

Teste33 retains actual dependency-use timestamps and uses a bounded LRU:

| AIR totalMemory | Optional ready libraries retained | Nominal cost allowance |
| --- | ---: | ---: |
| Below512MiB | 256 | 128MiB |
| 512..767MiB | 128 | 64MiB |
| 768..1023MiB | 64 | 32MiB |
| 1024MiB or more, or explicit forced cleanup | 0 | 0 |

Cost uses the preexisting512KiB-per-library estimate; this is not a measured
GPU/bitmap byte limit. The normal cache remains bounded, expires after ten
unused minutes, and preserves native mandatory/loading libraries. Explicit
cleanup and native memory-warning paths remain available. Furniture cache,
download concurrency, URL/revision handling, and per-avatar image disposal are
unchanged. Reentry still receives current room state and creates new room
render objects; it is not promised to be instantaneous.

## Verification

`VerifyFeatures33` executes the **saved AVM2**, reproducing the prior failures:

- Hiders hide themselves/each other in Teste32. Teste33 keeps them visible and
  clickable in normal, overlapping and inverted areas, while testing repeated
  controller opt-in toggles.
- The old native plane heuristic identifies an island as a door. The old
  RoomMessageHandler raises that island to the wall height. Teste33 leaves it
  flat, preserves connected entrances in both orientations, and continues past
  an earlier invalid island to a real entrance.
- A fixture with40 figures using200 distinct loaded libraries exercises the
  actual native renderer purge, native download-library state transitions and
  native figure-readiness check. Teste32 disposes136 libraries and leaves only
  12/40 figures immediately ready. Teste33 disposes none, leaves all40 ready
  after two exits, and correctly disposes unused libraries after ten minutes.
  These are deterministic fixture results, not device speed measurements.
- Five simulated memory levels test the capacity, newest-first eviction,
  explicit forced cleanup, mandatory libraries and pending downloads.

`AuditFeatures33` confirms34780 unrelated method bodies unchanged, exactly two
native method changes, one new geometry helper, and identical protocol tables.
The two recompiled production helpers are AreaHide30 and ClientCache23.
`VerifyFeatures32` and `VerifyRegression30` also pass, covering area geometry,
immediate visibility, offline UI/translations, prior room-entry1069, editor
closure and panning, navigator, cache, login, Wired, marketplace and currencies.
The shared AVM2 fixture was extended only to recognize RoomGeometry33.

XML serialization, native display event delivery, resource-provider I/O, GPU,
and physical Android/live-hotel behavior remain explicit test boundaries. No
physical-device performance or live account test was performed.

## Rebuild and package

Use Java17 and official JPEXS26.4.0 at `.task-tools/ffdec/ffdec.jar` (external
dependency; not included). Run `bash work/build_features33.sh` from this root.
It recompiles the two helpers over Teste32, compiles RoomGeometry33, installs the
two native method patches, and runs focused, audit and regression checks.

Restore the existing private signing key/certificate separately, then run
`python3 work/make_login_apk33.py output/Habbo_2.32.0_LoginSSO_Teste32.apk`.
The script refuses a mismatched certificate, increments the Android version,
and verifies that only the SWF and Android/AIR version metadata changed.
`verify_signed_apk18.py NEW_APK BASE_APK` independently verifies APKv2 content
digests/signature and APKv1/v2 certificate continuity. Private signing files
are removed after packaging and excluded from the sources ZIP.
