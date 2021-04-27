#!/usr/bin/env bash
function help {
    echo "doc"
    echo "-q Q               对jpeg格式图片进行图片质量因子为Q的压缩"
    echo "-r R               对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩成R分辨率"
    echo "-w font_size text  对图片批量添加自定义文本水印"
    echo "-p text            统一添加文件名前缀，不影响原始文件扩展名"
    echo "-s text            统一添加文件名后缀，不影响原始文件扩展名"
    echo "-t                 将png/svg图片统一转换为jpg格式图片"
    echo "-h                 帮助文档"
}

#对ipeg格式图片进行图片质量压缩
# convert filename1 -resize 30% filename2
function compressQuality {
    for img in *.jpeg ; do
	    [[ -e "$img" ]] || break
	    convert "$img" -quality "$1" "$img"
		echo "$img has been compressed of quality $1"
	done
}
#对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
# convert filename1 -resize 50% filename2
function compressRseolution {
    for img in *.jpeg *.png *.svg; do
		[[ -e "$img" ]] || break
	    convert "$img" -resize "$1" "$img"
	    echo "$img has benn resized"
	done
}

#对图片批量添加自定义文本水印
#convert filename1 -pointsize 50 -fill black -gravity center -draw "text 10,10 'Works like magick' " filename2
function watermark {
        for img in *; do
		[[ -e "$img" ]] || break
	    convert "$img" -pointsize "$1" -fill black -gravity southeast -draw "text 10,10 '$2'" "$img"
		echo "$img has benn watermarked with $2"
	done
}

#批量重命名 （统一添加文件前缀或后缀，不影响原始文件扩展名）
# mv filename1 filename2
function prefix {
    for img in *; do
		[[ -e "$img" ]] || break
	    mv "$img" "$1""$img"
		echo "$img has been added prefix"
	done	    
}
function suffix {
    for img in *; do
		[[ -e "$img" ]] || break	
	    mv "$img" "$img""$1"
		echo "$img has been added suffix"
	done
}

#将png/svg图片统一转换为jpg格式图片
#convert xxx.png xxx.jpg
function transform2jpg {
        for img in *.png *.svg; do
		[[ -e "$img" ]] || break
		filename=${img%.*}".jpg"
	    convert "$img" "${filename}"
		echo "transform $img to jpg"
	done
}
while [ "$1" != "" ];do
case "$1" in
    "-q")
        compressQuality "$2"
        exit 0
        ;;
    "-r")
        compressRseolution "$2"
        exit 0
        ;;
    "-w")
        watermark "$2" "$3"
        exit 0
        ;;
    "-p")
        prefix "$2"
        exit 0
        ;;
    "-s")
        suffix "$2"
        exit 0
        ;;
    "-t")
        transform2jpg
        exit 0
        ;;
    "-h")
        help
        exit 0
        ;;
esac
done