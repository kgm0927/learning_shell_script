#!/bin/bash
#nicenumber--주어진 숫자는 쉼표로 구분된 형식으로 표시된다.
#   (decimal point delimiter - 소수점) 및 TD(thousands delimiter - 천단위 구분
#   기호)가 인스턴스화 될 것으로 예상된다.
#   nicenum을 인스턴스화하거나 두 번째 arg가 지정되면 출력이 stdout으로 보내진다.

nicenumber(){
    # 스크립트에서 '.'는 INPUT 값의 소수점 구분 기호다.
    # 사용자가 -d 플래그로 지정하지 않는 한 출력값 소수점 구분 기호는 '.'이다.

    integer=$(echo $1 | cut -d. -f1) # 소수점의 왼쪽    # 1
    decimal=$(echo $1 | cut -d. -f2) # 소수점의 오른쪽  # 2

    # 숫자에 정수 부분 이상이 있는지 확인한다.
    if [ "$decimal" != "$1" ]; then
    # 분수 부분이 있으므로 포함시킨다.
    result="${DD:='.'}$decimal"
    fi

    thousands=$integer

    while [ $thousands -gt 999 ]; do # 3
        remainder=$(($thousands % 1000)) # 4 # 세 자리  최하위 숫자.

        # 세 자리 숫자를 위해 'remainder'가 필요. 0을 추가하길 원하는가?
        while [ ${#remainder} -lt 3 ]; do # 앞에 0을 붙인다.
            remainder="0$remainder"
        done

        result="${TD:=","}${remainder}${result}" # 5
        thousands=$(($thousands/1000))           # 6 # reminder의 왼쪽으로
    done

    nicenum="${thousands}${result}"
    if [ ! -z $2 ]; then
    echo $nicenum
    fi
}

DD="." # 전체 및 소수값 구분하는 소수점 구분 기호
TD="," # 매 세 자리를 구분하는 천 단위 구분 기호

# 메인 스크립트 시작
# =====================

while getopt "d:t:" opt; do # 7
    case $opt in
    d ) DD="$OPTARG" ;;
    t ) TD="$OPTARG" ;;
    esac
done

shift $(($OPTIND - 1))

# 입력 유효성 검사

if [ $# -eq 0 ]; then
    echo "Usage: $(basename $0) [-d c] [-t c] number"
    echo "  -d specifies the decimal point delimiter"
    echo "  -t specifies the thousands delimiter"
    exit 0
fi

nicenumber $1 # 8 # 두 번째 인자는 nicenumber를 'echo'로 출력한다.

exit 0