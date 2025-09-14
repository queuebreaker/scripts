main()
{
    mapfile -t INPOPS < $*

    for i in "${!INPOPS[@]}"
    do
        case "${INPOPS[i]}" in
            PUTA) OUTOPS+=('A=$HAND');;
            PUTB) OUTOPS+=('B=$HAND');;
            PUTC) OUTOPS+=('C=$HAND');;
            PUTD) OUTOPS+=('D=$HAND');;
            PUTE) OUTOPS+=('E=$HAND');;
            PUTF) OUTOPS+=('F=$HAND');;
            PUTG) OUTOPS+=('G=$HAND');;
            PUTH) OUTOPS+=('H=$HAND');;
            GETA) OUTOPS+=('HAND=$A');;
            GETB) OUTOPS+=('HAND=$B');;
            GETC) OUTOPS+=('HAND=$C');;
            GETD) OUTOPS+=('HAND=$D');;
            GETE) OUTOPS+=('HAND=$E');;
            GETF) OUTOPS+=('HAND=$F');;
            GETG) OUTOPS+=('HAND=$G');;
            GETH) OUTOPS+=('HAND=$H');;
            MARK) OUTOPS+=('while');;
            BACK) OUTOPS+=("[[ \$HAND -ne 0 ]]; do true; done");;
            BRAK) OUTOPS+=("[[ \$HAND -eq 0 ]] && break");;
            CONT) OUTOPS+=("[[ \$HAND -eq 0 ]] && continue");;
            INCR) OUTOPS+=('HAND=$((HAND + 1))');;
            DECR) OUTOPS+=('HAND=$((HAND - 1))');;
            YELL) OUTOPS+=('echo $HAND');;
            '') true;;
            *) OUTOPS+=("HAND=${INPOPS[i]}");;
        esac
    done

    echo '#!/bin/bash' > lazy.sh
    echo '# This file has been auto-generated with lc.' >> lazy.sh
    echo 'HAND=0; A=0; B=0; C=0; D=0; E=0; F=0; G=0; H=0' >> lazy.sh

    for i in "${!OUTOPS[@]}"
    do
        echo "${OUTOPS[$i]}" >> "$OUTFILE".sh
    done
}

main "$@"
