#!/usr/local/bin/lispscript

(defvar /where-am-i/ "/home/tony/.zsh/more-scripts/sync-with-android/")

(load (fn "~A/data.lisp" /where-am-i/))


(defvar /HOME/ (zsh "echo $HOME"))
(defvar /CMUS-HOME/ (zsh "echo $CMUS_HOME"))
(defvar /PLAYLIST-HOME/ (fn •~A/playlists/• /CMUS-HOME/))
(defvar /MUSIC-LOCATION/ (fn •~A/Dropbox/music/• /HOME/))
(defvar /ANDROID-HOME/ "/data/data/com.termux/files/home/")
(defvar /ANDROID-PREFIX/ (fn "~A/storage/" /ANDROID-HOME/))
(defvar /PICTURES-PREFIX/ (fn "~A/pictures/" /ANDROID-PREFIX/))
(defvar /PHOTOS-PREFIX/ (fn "~A/dcim/Camera" /ANDROID-PREFIX/))
(defvar /ANDROID-USER/ "u0_a207")
(defvar /WHATSAPP-DB-LOCATION/ "/data/data/com.whatsapp/databases/msgstore.db")
(defvar /MESSAGES-DB-LOCATION/ "/data/data/com.google.android.apps.messaging/databases/bugle_db")
(defvar /TMP-DIR/ (fn "~A/Desktop/ANDROID-SYNC-~A" /HOME/ (get-unix-time)))
(defvar /LENGTH/ 0)

(zsh (fn "mkdir '~A'" /TMP-DIR/) :echo t)

(ft "~%")
(when (y-or-n-p "Pull picture folders off phone?")
  (ft (yellow "Pulling picture folders off phone~%"))
  (for-each/list /pic-folders-to-pull/
    (let ((tmppath (fn "~A~A" /PICTURES-PREFIX/ value!)))
      « (zsh (fn •rsync -Phav 'android:~A' '~A'• tmppath /TMP-DIR/)
             :echo t
             :return-string nil)
          OR DO (format *error-output* (red "failed~%")) » )))

(ft "~%")
(when (y-or-n-p "Delete pulled picture folders?")
  (for-each/list /pic-folders-to-pull/
    (let ((tmppath (fn "~A~A" /PICTURES-PREFIX/ value!)))
      (when (y-or-n-p (fn "delete folder: ~A ?" tmppath))
        « (zsh (fn •ssh android rm -rf ~A• tmppath) :echo t)
            OR DO (format *error-output* (red "failed~%")) » ))))

(ft "~%")
(when (y-or-n-p "Pull photos off phone?")
  (ft (yellow "Pulling picture folders off phone~%"))
  « (zsh (fn •rsync -Phav 'android:~A' '~A'• /PHOTOS-PREFIX/ /TMP-DIR/)
         :echo t
         :return-string nil)
      OR DO (format *error-output* (red "failed~%")) »
  « (zsh (fn "jhead -autorot ~A/Camera/*.jpg" /TMP-DIR/)
         :echo t
         :return-string nil)
      OR DO (format *error-output* (red "failed~%")) » )

(ft "~%")
(when (y-or-n-p "Delete photo folder?")
  « (zsh (fn •ssh android rm -rf ~A• /PHOTOS-PREFIX/) :echo t)
      OR DO (format *error-output* (red "failed~%")) » )

(ft "~%")
(when (y-or-n-p "Pull WhatsApp database?")
  « (zsh (fn •ssh android "su -c 'cp ~A ~A'"•
             /WHATSAPP-DB-LOCATION/ /ANDROID-HOME/) :echo t)
      OR DO (format *error-output* (red "failed~%")) »
  « (zsh (fn •ssh android "su -c 'chown ~A ~A/msgstore.db'"•
             /ANDROID-USER/ /ANDROID-HOME/) :echo t)
      OR DO (format *error-output* (red "failed~%")) »
  « (zsh (fn •rsync -Phav android:~A/msgstore.db '~A'•
           /ANDROID-HOME/ /TMP-DIR/) :echo t :return-string nil)
      OR DO (format *error-output* (red "failed~%")) »
  « (zsh (fn •ssh android "rm ~A/msgstore.db"•
             /ANDROID-HOME/) :echo t)
      OR DO (format *error-output* (red "failed~%")) » )

(ft "~%")
(when (y-or-n-p "Pull Messages database?")
  « (zsh (fn •ssh android "su -c 'cp ~A ~A'"•
             /MESSAGES-DB-LOCATION/ /ANDROID-HOME/) :echo t)
      OR DO (format *error-output* (red "failed~%")) »
  « (zsh (fn •ssh android "su -c 'chown ~A ~A/bugle_db'"•
             /ANDROID-USER/ /ANDROID-HOME/) :echo t)
      OR DO (format *error-output* (red "failed~%")) »
  « (zsh (fn •rsync -Phav android:~A/bugle_db '~A'•
           /ANDROID-HOME/ /TMP-DIR/) :echo t :return-string nil)
      OR DO (format *error-output* (red "failed~%")) »
  « (zsh (fn •ssh android "rm ~A/bugle_db"•
             /ANDROID-HOME/) :echo t)
      OR DO (format *error-output* (red "failed~%")) » )

(ft "~%")
(when (y-or-n-p "Sync picture folders?")
  (setq /LENGTH/ (length /pic-folders-to-push/))
  (for-each/list /pic-folders-to-push/
    (progress index! /LENGTH/)
    (ft "syncing album: ~A~%" (green value!))
    « (zsh (fn •rsync -Phav --delete "~A/Dropbox/Carlos IV/Backups/Pictures/~A" android:~A•
               /HOME/ value! /PICTURES-PREFIX/) :echo t :return-string nil)
      OR DO (format *error-output* (red "failed~%")) » ))

(ft "~%")
(when (y-or-n-p "Sync music playlists?")
  (zsh (fn "mkdir -p ~A/music" /TMP-DIR/) :echo t)
  (for-each/list /playlists-to-push/
    (setq /LENGTH/ (length /playlists-to-push/))
    (let ((playlist value!)
          (full (fn •~A/~A• /PLAYLIST-HOME/ value!)))
      (ft "On playlist: ~A~%" (yellow "~A" playlist))
      (zsh (fn •mkdir -p "~A/music/~A"• /TMP-DIR/ playlist)) :echo t
      (for-each/line full
        (zsh (fn •ln -sf "~A" "~A/music/~A"• value! /TMP-DIR/ playlist)))))
  (zsh (fn •rsync -PhrtLav --delete ~A/music/ android:~A/music•
            /TMP-DIR/ /ANDROID-PREFIX/) :echo t :return-string nil)
  (zsh (fn "rm -rf ~A/music" /TMP-DIR/) :echo t))

(ft (green "~%done!~%"))
