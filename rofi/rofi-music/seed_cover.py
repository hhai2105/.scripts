#!/usr/bin/env python
import os

coverdir = "/home/hain/.config/mpd/Cover/"
MusicDir = "/mnt/sda1/Music/"

def find_cover(self, song_url):
    if song_url.startswith('file://'):
        song_path = song_url[7:]

    song_dir = os.path.dirname(song_path)

    # Try existing temporary file
    if self._temp_cover:
        if song_url == self._temp_song_url:
            logger.debug("find_cover: Reusing old image at %r" % self._temp_cover.name)
            return 'file://' + self._temp_cover.name
        else:
            logger.debug("find_cover: Cleaning up old image at %r" % self._temp_cover.name)
            self._temp_song_url = None
            self._temp_cover.close()

    # Search for embedded cover art
    song = None
    if mutagen and os.path.exists(song_path):
        try:
            song = mutagen.File(song_path)
        except mutagen.MutagenError as e:
            logger.error("Can't extract covers from %r: %r" % (song_path, e))
    if song is not None:
        if hasattr(song, "pictures"):
            # FLAC
            for pic in song.pictures:
                if pic.type == mutagen.id3.PictureType.COVER_FRONT:
                    self._temp_song_url = song_url
                    return self._create_temp_cover(pic)
        if song.tags:
            # present but null for some file types
            for tag in song.tags.keys():
                if tag.startswith("APIC:"):
                    for pic in song.tags.getall(tag):
                        if pic.type == mutagen.id3.PictureType.COVER_FRONT:
                            self._temp_song_url = song_url
                            return self._create_temp_cover(pic)
                elif tag == "metadata_block_picture":
                    # OGG
                    for b64_data in song.get(tag, []):
                        try:
                            data = base64.b64decode(b64_data)
                        except (TypeError, ValueError):
                            continue

                        try:
                            pic = mutagen.flac.Picture(data)
                        except mutagen.flac.error:
                            continue

                        if pic.type == mutagen.id3.PictureType.COVER_FRONT:
                            self._temp_song_url = song_url
                            return self._create_temp_cover(pic)
                elif tag == "covr":
                    # MP4
                    for data in song.get(tag, []):
                        mimes = {mutagen.mp4.AtomDataType.JPEG: "image/jpeg",
                                    mutagen.mp4.AtomDataType.PNG: "image/png"}

                        pic = mutagen.id3.APIC(mime=mimes.get(data.imageformat, ""), data=data)

                        self._temp_song_url = song_url
                        return self._create_temp_cover(pic)

    # Look in song directory for common album cover files
    if os.path.exists(song_dir) and os.path.isdir(song_dir):
        for f in os.listdir(song_dir):
            if self._params['cover_regex'].match(f):
                return 'file://' + os.path.join(song_dir, f)

    # Search the shared cover directories
    if 'xesam:artist' in self._metadata and 'xesam:album' in self._metadata:
        artist = ",".join(self._metadata['xesam:artist'])
        album = self._metadata['xesam:album']
        for template in downloaded_covers:
            f = os.path.expanduser(template % (artist, album))
            if os.path.exists(f):
                return 'file://' + f

    return None

def main():
    print(MusicDir)
    for root, dirnames, filenames in os.walk(MusicDir):
        for filename in filenames:
            print(filenames)

if  __name__ == "__main__":
    main()
