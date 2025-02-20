#!/bin/bash

function ng_check_seq {
    test=0

    for i in $(seq 3); do
        j=$((3 - ( i - 1 )))
        k=$((2 - ( i - 1 )))

        if [[ $(( ${arr[$j]} - ${arr[$k]} )) -eq 1 ]] ; then
            test=$((test + 1))
        else
            true
        fi
    done

    if [[ $test -eq 3 ]] ; then
        return 0
    else
        return 1
    fi
}

function ng_check_rseq {
    test=0

    for i in $(seq 3); do
        j=$((3 - ( i - 1 )))
        k=$((2 - ( i - 1 )))

        if [[ $(( ${arr[$k]} - ${arr[$j]} )) -eq 1 ]] ; then
            test=$((test + 1))
        else
            true
        fi
    done

    if [[ $test -eq 3 ]] ; then
        return 0
    else
        return 1
    fi
}

function ng_check_id {
    if grep -qE '^([0-9]+)( \1)*$' <<< "${arr[@]}"; then 
        return 0
    else
        return 1
fi
}

function ng_check_22 {
    sum=0

    for i in $(seq 4); do
        j=$((i - 1))
        sum=$((sum + ${arr[$j]}))
    done

    if [[ $sum -eq 22 ]]; then
        return 0
    else
        return 1
    fi
}

function ng_check_11 {
    sum=0

    for i in $(seq 4); do
        j=$((i - 1))
        sum=$((sum + ${arr[$j]}))
    done

    if [[ $sum -eq 11 ]]; then
        return 0
    else
        return 1
    fi
}

function ng_check_33 {
    sum=0

    for i in $(seq 4); do
        j=$((i - 1))
        sum=$((sum + ${arr[$j]}))
    done

    if [[ $sum -eq 33 ]]; then
        return 0
    else
        return 1
    fi
}

function ng_check_ao {
    test=0

    for i in $(seq 4); do
        j=$((i - 1))
        if [[ $((${arr[$j]} % 2)) -eq 1 ]]; then
            test=$((test + 1))
        else
            true
        fi
    done

    if [[ $test = 4 ]]; then
        return 0
    else
        return 1
    fi
}

function ng_check_ae {
    test=0
    for i in $(seq 4); do
        j=$((i - 1))
        if [[ $((${arr[$j]} % 2)) -eq 0 ]]; then
            test=$((test + 1))
        else
            true
        fi
    done

    if [[ $test = 4 ]]; then
        return 0
    else
        return 1
    fi
}

function ng_check_m3 {
    test=0
    for i in $(seq 4); do
        j=$((i - 1))
        if [[ $((${arr[$j]} % 3)) -eq 0 ]]; then
            test=$((test + 1))
        else
            true
        fi
    done

    if [[ $test = 4 ]]; then
        return 0
    else
        return 1
    fi
}

function ng_check_sml {
    test=0

    for i in $(seq 4); do
        j=$((i - 1))
        if [[ $((5 - ${arr[$j]})) -gt 0 ]]; then
            test=$((test + 1))
        else
            true
        fi
    done

    if [[ $test = 4 ]]; then
        return 0
    else
        return 1
    fi
}

function ng_check_big {
    test=0

    for i in $(seq 4); do
        j=$((i - 1))
        if [[ $((${arr[$j]} - 6)) -gt 0 ]]; then
            test=$((test + 1))
        else
            true
        fi
    done

    if [[ $test = "4" ]]; then
        return 0
    else
        return 1
    fi
}

function ng_check_iar {
    test=0

    for i in $(seq 3); do
        j=$((3 - ( i - 1 )))
        k=$((2 - ( i - 1 )))

        if [[ $(( ${arr[$j]} - ${arr[$k]} )) -gt 0 ]] ; then
            test=$((test + 1))
        else
            true
        fi
    done

    if [[ $test -eq 3 ]] ; then
        return 0
    else
        return 1
    fi
}

function ng_check_riar {
    test=0

    for i in $(seq 3); do
        j=$((3 - ( i - 1 )))
        k=$((2 - ( i - 1 )))

        if [[ $(( ${arr[$k]} - ${arr[$j]} )) -gt 0 ]] ; then
            test=$((test + 1))
        else
            true
        fi
    done

    if [[ $test -eq 3 ]] ; then
        return 0
    else
        return 1
    fi
}

function ng_check_rep {
    if [[ "${arr[0]}""${arr[1]}" == "${arr[2]}""${arr[3]}" ]] ; then
        return 0
    else
        return 1
    fi
}

function ng_check_pair {
    if [[ "${arr[0]}" == "${arr[1]}" && "${arr[2]}" == "${arr[3]}" ]] ; then
        return 0
    else
        return 1
    fi
}

function ng_finalize {
    TP=$((PP + NP))
    NEWNUM=${NUM//$SEQ/}

    if [[ -n "$NEWNUM" ]] ; then
        echo "$SEQ: $WP, +$NP points ($TP points total)"
        echo
        echo "-t ng $NEWNUM $TP SEQ"
        exit 0
    else
        echo "$SEQ: $WP, +$NP points ($TP points total)"
        echo
        echo "game over, score: $TP"
        exit 0
    fi
}

NUM=$1
PP=$2
SEQ=$3

arr=()

for i in $(seq 4); do
    j=$((i - 1))
    arr+=("${SEQ:$j:1}")
done

if [[ -z $1 ]]; then
    NUM=''

    for i in $(seq 24); do
        NUM=$NUM$(shuf -i 0-9 -n 1)
    done
    
    echo "$NUM"
    echo
    echo "-t ng $NUM 0 SEQ"
    
    exit 0
else
    if [[ ${#SEQ} -eq 4 ]]; then
        if echo "$NUM" | grep -q "$SEQ"; then
            if ng_check_id; then
                NP=420
                WP="identicals"
                ng_finalize
            else
                if ng_check_seq; then
                    NP=350
                    WP="sequentials"
                    ng_finalize
                else
                    if ng_check_rseq; then
                        NP=350
                        WP="sequentials"
                        ng_finalize
                    else
                        if ng_check_m3; then
                            NP=51
                            WP="multiples of 3"
                            ng_finalize
                        else
                            if ng_check_rep; then
                                NP=42
                                WP="repetition"
                                ng_finalize
                            else
                                if ng_check_pair; then
                                    NP=42
                                    WP="pair"
                                    ng_finalize
                                else
                                    if ng_check_11; then
                                        NP=21
                                        WP="add up to 11"
                                        ng_finalize
                                    else
                                        if ng_check_22; then
                                            NP=21
                                            WP="add up to 22"
                                            ng_finalize
                                        else
                                            if ng_check_33; then
                                                NP=21
                                                WP="add up to 33"
                                                ng_finalize
                                            else
                                                if ng_check_sml; then
                                                    NP=17
                                                    WP="smallers"
                                                    ng_finalize
                                                else
                                                    if ng_check_big; then
                                                        NP=17
                                                        WP="largers"
                                                        ng_finalize
                                                    else
                                                        if ng_check_ao; then
                                                            NP=17
                                                            WP="odds"
                                                            ng_finalize
                                                        else
                                                            if ng_check_ae; then
                                                                NP=17
                                                                WP="evens"
                                                                ng_finalize
                                                            else
                                                                if ng_check_iar; then
                                                                    NP=10
                                                                    WP="in a row"
                                                                    ng_finalize
                                                                else
                                                                    if ng_check_riar; then
                                                                        NP=10
                                                                        WP="in a row"
                                                                        ng_finalize
                                                                    else
                                                                        NP=0
                                                                        WP="no pattern"
                                                                        ng_finalize
                                                                    fi
                                                                fi
                                                            fi
                                                        fi
                                                    fi
                                                fi
                                            fi
                                        fi
                                    fi
                                fi
                            fi
                        fi
                    fi
                fi
            fi 
        else
            echo "ERROR: no such sequence in number"
        fi
    else
        echo "ERROR: sequence is not 4 numbers long"
    fi
fi
