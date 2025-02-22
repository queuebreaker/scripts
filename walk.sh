#!/bin/bash

function w_get {

    SEEDLEN=$(($(echo "$SEED_IN" | grep -o "," | wc -l) + 1))

    for i in $(seq $SEEDLEN); do
        SEED_N+=("$(echo "$SEED_IN" | cut -d "," -f "$i")")
    done

    for i in $(seq $SEEDLEN); do
        for j in $(seq "${SEED_N[$((i - 1))]:1:2}"); do
            SEED+=("${SEED_N[$((i - 1))]:0:1}")
        done
    done

    for i in $(seq 25); do
        j=$((i - 1))

        if [[ "${SEED[$j]}" == 'p' ]]; then
            TILE_PLAYER="$j"
        fi
    done
}

function w_check {
    i=$(($1 + $2))

    if [[ "${SEED[$i]}" == 'w' || $i -lt 0 || $i -gt 24 ]]; then
        MSG='you may not move there'

        return 1
    else
        SEED[$1]='t'
        SEED[i]='p'

        return 0
    fi
}

function w_disp {
    for i in $(seq 25); do
        j=$((i - 1))

        case "${SEED[$j]}" in
            t) eval T"$j"='.';;
            p) eval T"$j"='@';;
            x) eval T"$j"='X';;
            w) eval T"$j"='#';;
        esac
    done
}

function w_set {
    count=0
    var=''

    for i in $(seq 26); do
        j=$((i - 1))
        k=$((i - 2))

        if [[ "${SEED[$j]}" == "${SEED[$k]}" ]]; then
            count=$(($count + 1))
        else
            var=$var$count,"${SEED[$j]}"
            count=1
        fi
    done

    echo "${SEED[0]}""${var::-1}"
}

SEED_IN=$1
ACTION=$2
MSG='you are @, move using wasd, thats it for now but more is coming'

w_get

case $ACTION in
    w) w_check "$TILE_PLAYER" -5 && MSG='you moved north';;
    a) w_check "$TILE_PLAYER" -1 && MSG='you moved west';;
    s) w_check "$TILE_PLAYER" 5 && MSG='you moved south';;
    d) w_check "$TILE_PLAYER" 1 && MSG='you moved east';;
    *) w_check "$TILE_PLAYER" 0 && MSG='you did nothing';;
esac

w_disp

echo "$T0 $T1 $T2 $T3 $T4"
echo "$T5 $T6 $T7 $T8 $T9"
echo "$T10 $T11 $T12 $T13 $T14"
echo "$T15 $T16 $T17 $T18 $T19"
echo "$T20 $T21 $T22 $T23 $T24"
echo ""
echo "$MSG"
echo ""
echo "-t walk $(w_set) ACT"
