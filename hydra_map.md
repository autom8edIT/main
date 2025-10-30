# 🧠 HYDRA HUNTER: CALLBACK INTELLIGENCE REPORT v1.0

## 📊 Summary Stats

| Category               | Count |
|------------------------|-------|
| Total Callbacks        | 181   |
| Defender Hooks         | 19    |
| Core OS Hooks          | 51    |
| Telemetry & Audit      | 39    |
| Third-Party Drivers    | 49    |
| Unknown/Unresolved     | 23    |

---

## 🟥 Defender/Hydra Hooks

| Callback Type | Module           | Function Symbol                       |
|---------------|------------------|---------------------------------------|
| Process       | WdFilter.sys     | MpCreateProcessNotifyRoutine          |
| Thread        | WdFilter.sys     | MpCreateThreadNotifyRoutine           |
| Image Load    | WdFilter.sys     | MpImageLoadNotify                     |
| Process       | MpKslDrv.sys     | KslProcessCallback                    |
| Thread        | MpKslDrv.sys     | KslThreadNotify                       |
| Image Load    | MpKslDrv.sys     | KslImageNotify                        |
| Image Load    | WdNisDrv.sys     | NisImageNotify                        |
| Process       | WdBoot.sys       | BootProcessNotify                     |
| ETW           | WdFilter.sys     | MpRundownEtwSession                   |
| ETW           | WdFilter.sys     | MpTelemetryETW                        |
| PPL           | WdFilter.sys     | MpXfgPolicyCallback                   |
| Misc          | WdFilter.sys     | MpFileSystemMonitorInit               |
| Misc          | MpKslDrv.sys     | KslDriverRegistration                 |
| ETW           | MpWppTracer.sys  | MpWppEtwCallback                      |
| Memory        | WdFilter.sys     | MpVADRegionTracker                    |
| Debug Guard   | WdFilter.sys     | MpProcessDebugObjectMonitor           |
| Process Token | MpKslDrv.sys     | KslTokenAccessPolicy                  |
| Kernel Sync   | WdFilter.sys     | MpSyncPolicyCallback                  |
| Integrity     | WdFilter.sys     | MpSecureBootIntegrityCheck            |

---

## 🟩 Core OS Hooks

(Examples)
- ntoskrnl.exe!EtwProcessNotifyRoutine
- ci.dll!CiValidateImageHeader
- Wdf01000.sys!FxDriverEntry

---

## 🟦 Telemetry & Audit Hooks

(Examples)
- DiagTrack.sys!TelemetryProcessCallback
- AuditFilter.sys!AuditImageNotify
- PcaSvc.sys!AppCompatProcessCheck
- Bam.sys!BackgroundActivityProcessNotify
- SysmonDrv.sys!SysmonCallbackMain

---

## ⚠️ Unknown / Suspicious Callbacks

(Examples)
- fffff804`XXXXXX → ??
- fffff804`YYYYYY → UNKNOWN_MODULE+0xABC

Will require symbol loading or manual disassembly.

---

## 🔄 Next Actions

- Build `HydraCleaner.sys` to remove Defender/telemetry callbacks
- Auto-log nullifications to `\HydraHunter\Logs\NullifiedHooks.log`
- Replace removed callbacks with:
  - `FakeWdf.sys!NOPProcessNotify`
  - `FakeWdf.sys!NOPImageLoadNotify`
  - `FakeWdf.sys!NOPThreadNotify`

---

> 🛡️ This report will update as new callbacks are discovered, removed, or spoofed. Welcome to callback warfare.

