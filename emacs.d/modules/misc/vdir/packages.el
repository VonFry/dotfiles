;;; vdir config -*- lexical-binding: t -*-

(package! khardel
  :general
  (+mmap-at-def
    "c c" 'khardel-choose-contact
    "c m" 'khardel-insert-email
    "c n" 'khardel-new-contact
    "c E" 'khardel-edit-finish
    "c e" 'khardel-edit-contact))
