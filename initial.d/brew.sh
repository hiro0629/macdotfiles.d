#!/usr/bin/env bash
set -euo pipefail

echo ">>> Xcode Command Line Tools を確認中..."
if ! xcode-select -p &>/dev/null; then
  echo ">>> xcode-select --install を実行します（ダイアログでインストールしてください）"
  xcode-select --install || true
else
  echo ">>> Xcode Command Line Tools OK"
fi

echo ">>> Homebrew を確認中..."
if ! command -v brew &>/dev/null; then
  echo ">>> Homebrew が見つかりません。インストールします..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo ">>> Homebrew はすでにインストールされています"
fi

# Apple Silicon / Intel 両対応で brew の環境を読み込む
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo ">>> brew update..."
brew update

echo ">>> 必要な tap を追加 (フォントなど)..."
brew tap homebrew/cask-fonts

# ============================================
#  Formulae
#  （今の環境の brew list をベースに作成）
# ============================================
FORMULAE=(
  aom
  aribb24
  autoconf
  bat
  brotli
  c-ares
  ca-certificates
  cairo
  certifi
  cjson
  cmatrix
  colima
  csvkit
  dav1d
  docker
  docker-buildx
  docker-completion
  docker-compose
  dust
  eza
  fd
  ffmpeg
  ffmpeg@7
  ffmpegthumbnailer
  flac
  fontconfig
  freetype
  frei0r
  fribidi
  fzf
  gawk
  gettext
  giflib
  git
  glib
  gmp
  gnupg
  gnutls
  gpgme
  gpgmepp
  graphite2
  harfbuzz
  highway
  icu4c@77
  imagemagick
  imath
  jasper
  jpeg-turbo
  jpeg-xl
  krb5
  lame
  lazygit
  leptonica
  libarchive
  libass
  libassuan
  libb2
  libbluray
  libde265
  libdeflate
  libevent
  libgcrypt
  libgit2
  libgpg-error
  libheif
  libidn2
  libksba
  liblqr
  libmediainfo
  libmicrohttpd
  libmms
  libnghttp2
  libnghttp3
  libngtcp2
  libogg
  libomp
  libpng
  libpq
  libraw
  librist
  libsamplerate
  libsndfile
  libsodium
  libsoxr
  libssh
  libssh2
  libtasn1
  libtiff
  libtool
  libudfread
  libunibreak
  libunistring
  libusb
  libuv
  libvidstab
  libvmaf
  libvorbis
  libvpx
  libx11
  libxau
  libxcb
  libxdmcp
  libxext
  libxrender
  libzip
  libzen
  lima
  little-cms2
  lpeg
  luajit
  luv
  lz4
  lzo
  m4
  mbedtls
  media-info
  mpdecimal
  mpfr
  mpg123
  ncurses
  nettle
  node
  npth
  nspr
  nss
  oniguruma
  opencore-amr
  openexr
  openjpeg
  openjph
  openssl@3
  opus
  p11-kit
  pango
  pcre2
  pinentry
  pixman
  pkgconf
  poppler
  procs
  pyenv
  python@3.13
  python@3.14
  rav1e
  readline
  ripgrep
  rubberband
  sdl2
  shared-mime-info
  simdjson
  sl
  snappy
  speex
  sqlite
  srt
  starship
  stow
  svt-av1
  tesseract
  theora
  tmux
  trash-cli
  tree
  tree-sitter
  unbound
  unibilium
  utf8proc
  uvwasi
  webp
  x264
  x265
  xorgproto
  xvid
  xz
  yazi
  yt-dlp
  zeromq
  zimg
  zoxide
  zstd
)

# ============================================
#  Casks (GUI アプリ)
# ============================================
CASKS=(
  font-hack-nerd-font
  hammerspoon
  stats
  vimr
  wezterm
)

echo ">>> Formulae をインストール..."
for pkg in "${FORMULAE[@]}"; do
  if brew list --formula "$pkg" &>/dev/null; then
    echo "  - $pkg (already installed)"
  else
    echo "  + brew install $pkg"
    brew install "$pkg"
  fi
done

echo ">>> Casks (アプリ) をインストール..."
for cask in "${CASKS[@]}"; do
  if brew list --cask "$cask" &>/dev/null; then
    echo "  - $cask (already installed)"
  else
    echo "  + brew install --cask $cask"
    brew install --cask "$cask"
  fi
done

echo ">>> brew cleanup..."
brew cleanup

echo "✅ Homebrew セットアップ完了！"
echo "   あとは dotfiles リポジトリを clone して stow/zshrc などを反映させれば OK です。"
