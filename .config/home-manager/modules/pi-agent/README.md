# Pi 작업 완료 알림

`home-manager switch` 후 Pi를 다시 실행하면 전송 방식을 자동으로 선택합니다.
실행 중인 Pi에는 `/reload`로 새 확장을 적용할 수 있습니다.

- 로컬 macOS: 기본 제공 `/usr/bin/osascript`의 `display notification` 사용.
  Nix로 설치한 WezTerm/terminal-notifier의 앱 서명 문제에 의존하지 않습니다.
- 로컬 Linux: Home Manager가 설치한 `libnotify`의 `notify-send` 사용.
  실행 경로를 확장에 직접 넣으므로 새 로그인이나 PATH 설정이 필요 없습니다.
- SSH: 원격 호스트의 데스크톱 대신 현재 터미널에 OSC 알림 전송.
- 네이티브 명령 실패·시간 초과: OSC로 대체하고 Pi 안에 경고 표시.
  명령이 성공하면 중복 OSC 알림은 보내지 않습니다.

macOS 알림 권한·집중 모드는 OS에서 관리합니다. AppleScript 알림은
macOS 버전에 따라 Script Editor 등의 이름으로 표시될 수 있습니다.
명령이 성공해도 실제 배너 표시까지 확인할 수 있는 것은 아닙니다.

Linux는 로그인한 데스크톱의 D-Bus 알림 서비스를 사용합니다(GNOME/KDE,
또는 이미 설정한 dunst/mako 등). 기존 데스크톱과 충돌할 수 있으므로 별도
알림 데몬을 강제로 설치하지 않습니다. 알림 서비스가 없는 환경은 OSC로
대체합니다. OSC의 실제 표시 여부는 접속한 터미널의 지원과 권한에 따릅니다.

설정 없이 기본 활성화됩니다. 취소된 작업과 비대화형 실행에는 알림을 보내지
않으며, 중간 재시도 대신 `agent_settled`에서 한 번 전송합니다.

진단용 명령(평소 사용할 필요 없음):

- `/notify status`: 활성화 상태와 자동 선택된 전송 방식
- `/notify test`: 실제 요청 전송, 실패 시 원인 표시
- `/notify on|off`: 현재 세션에서 알림 전환
- `PI_NOTIFY=0`: 비활성화한 상태로 시작

테스트:

```sh
node --experimental-strip-types --test modules/pi-agent/notify.test.mjs
```
