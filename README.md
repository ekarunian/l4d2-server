- mmsource-1.11.0-git1143-linux.tar.gzとsourcemod-1.10.0-git6499-linux.tar.gzを
  Steam\steamapps\common\left 4 dead 2\left4dead2\にコピー 
- metamod.vdfを
  Steam\steamapps\common\left 4 dead 2\left4dead2\addonsにコピー
- l4dtoolz(L4D2)-1.0.0.9h.zip を解凍した中身を
  Steam\steamapps\common\left 4 dead 2\left4dead2\addons\にコピー
- .smxを
  Steam\steamapps\common\left 4 dead 2\left4dead2\addons\sourcemod\plugins\
- .spを
  Steam\steamapps\common\left 4 dead 2\left4dead2\addons\sourcemod\scripting\
- l4dtoolz.vdfを
  Steam\steamapps\common\left 4 dead 2\left4dead2\addons\metamodにコピー
- sdkhooks13-l4d2.zipの中身を
  Steam\steamapps\common\left 4 dead 2\left4dead2\addons\sourcemod　にコピー

```console
$ docker run -it -p 27015:8080 27015:27015 --name=steamcmd ekarunian/l4d2-server:1.0 bash
$ ./steamcmd.sh +login anonymous +force_install_dir /home/steam/l4d2server +app_update 222860 +quit
```