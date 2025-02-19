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
    sum=0

    sum=$((${arr[0]} + ${arr[1]} + ${arr[2]} + ${arr[3]}))

    if [[ $sum == $((${arr[0]} * 4)) ]]; then
        return 0
    else
        return 1
    fi
}

function ng_check_20 {
    sum=0

    for i in $(seq 4); do
        j=$((i - 1))
        sum=$((sum + ${arr[$j]}))
    done

    if [[ $sum -eq 20 ]]; then
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

function ng_check_05 {
    test=0

    for i in $(seq 4); do
        j=$((i - 1))
        if [[ $((6 - ${arr[$j]})) -gt 0 ]]; then
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

function ng_check_69 {
    test=0

    for i in $(seq 4); do
        j=$((i - 1))
        if [[ $((${arr[$j]} - 5)) -gt 0 ]]; then
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

function ng_finalize {
    TP=$((PP + NP))
    NEWNUM=${NUM//$SEQ/}

    if [[ -n "$NEWNUM" ]] ; then
        echo "$SEQ: $WP, +$NP points ($TP points total)"
        echo
        echo "bash ng.sh $NEWNUM $TP SEQ"
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
    NUM=0

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
                NP=2000
                WP="all numbers identical"
                ng_finalize
            else
                if ng_check_seq; then
                    NP=1000
                    WP="all numbers sequential"
                    ng_finalize
                else
                    if ng_check_rseq; then
                        NP=1000
                        WP="all numbers sequential"
                        ng_finalize
                    else
                        if ng_check_20; then
                            NP=500
                            WP="all numbers add up to 20"
                            ng_finalize
                        else
                            if ng_check_ao; then
                                NP=200
                                WP="all numbers are odd"
                                ng_finalize
                            else
                                if ng_check_ae; then
                                    NP=200
                                    WP="all numbers are even"
                                    ng_finalize
                                else
                                    if ng_check_05; then
                                        NP=200
                                        WP="all numbers are less than 5,5"
                                        ng_finalize
                                    else
                                        if ng_check_69; then
                                            NP=200
                                            WP="all numbers are greater than 5,5"
                                            ng_finalize
                                        else
                                            if ng_check_iar; then
                                                NP=100
                                                WP="all numbers are in a row"
                                                ng_finalize
                                            else
                                                if ng_check_riar; then
                                                    NP=100
                                                    WP="all numbers are in a row"
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
        else
            echo "ERROR: no such sequence in number"
        fi
    else
        echo "ERROR: sequence is not 4 numbers long"
    fi
fi
