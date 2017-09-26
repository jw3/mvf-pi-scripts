#!/usr/bin/env bash

readonly camconfig="${2:-/etc/cams.json}"

screen() {
  local camname="$1"
  local player=$(jq --arg cam $camname -r '.cams[] | select(.name | contains($cam)) | "omxplayer --avdict rtsp_transport:tcp --win \"\(.screen)\" \"rtsp://\(.user):\(.pass)@\(.name):\(.port)\" --live -n -1"' ${camconfig})

  echo "$player"
  screen -dmS "$camname" sh -c "$player"
}

"$@"
