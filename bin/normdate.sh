#!/bin/bash
# normdate -- 날짜 지정에서 월 필드를 세 자로 정규화하여, 첫 글자는 대문자다.
#   스크립트 #7의 날짜 검증에 대한 도움 함수다.
#   오류가 없으면 0으로 종료한다.


monthNumToName(){
    # 'month' 변수를 적절한 값으로 설정한다.
    case $1 in
    1 ) month="Jan" ;; 2 ) month="Feb" ;;
    3 ) month="Mar" ;; 4 ) month="Apr" ;;
    5 ) month="May" ;; 6 ) month="Jun" ;;
    7 ) month="Jul" ;; 8 ) month="Aug" ;;
    9 ) month="Sep" ;; 10) month="Oct" ;;
    11) month="Nov" ;; 12) month="Dec" ;;
    * ) echo "$0: Unknown month value $1" >&2
        exit 1
    esac
    # 다른 스크립트에서 monthNumToName()을 이용하려면 다음 문자의 주석을 풀어준다.
    # echo $month $2 $3
    return 0
}

# 메인 스크립트 시작 -- 다른 스크립트에서 이 스크립트를 포함시키려면,
#   이 줄 아래의 모든 내용을 삭제하거나 주석 처리하면 된다.
#=================
if [ $# -eq 1 ]; then
	set -- $(echo $1 | sed 's/[\/\-]/ /g')
fi

if [ $# -ne 3 ] ; then
    echo "Usage: $0 month day year" >&2
    echo "Formats are August 3 1962 and 8 3 1962" >&2
    exit 1
fi
if [ $3 -le 99 ] ; then
    echo "$0: expected 4-digit year value." >&2
    exit 1
fi


# month 입력 포맷은 숫자인가?
if [ -z $(echo $1|sed 's/[[:digit:]]//g') ]; then
    monthNumToName $1
    else
    # 처음 세 글자를 첫 번째는 대문자, 그다음은 소문자로 정규화한다.
    month="$(echo $1|cut -c1|tr '[:lower:]' '[:upper:]')" #2
    month="$month$(echo $1|cut -c2-3|tr '[:upper:]' '[:lower:]' )" #3

fi

echo $month $2 $3

exit 0
