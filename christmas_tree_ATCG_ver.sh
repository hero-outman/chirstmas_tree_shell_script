#!/bin/bash
trap "tput reset; tput cnorm; exit" 2 # trap: dosomething signal; tput reset: reset terminal; tput cnorm: normal cursor
clear # clear screen
tput civis # cursor invisible
lin=2 # line number
col=$(($(tput cols) / 2))
c=$((col-1))
est=$((c-2))
color=0
tput setaf 2; tput bold # setaf <value>: Set foreground color; tput bold: bold

# Star of Bethlehem 
# $c : center  of the tree
tput cup $((lin - 1)) $c; echo -n \⭐

# Tree
for ((i=1; i<20; i+=2))
{
    tput cup $lin $col
    for ((j=1; j<=i; j++))
    {
        echo -n \*
    }
    let lin++
    let col--
}

tput sgr0; tput setaf 3

# Trunk
for ((i=1; i<=2; i++))
{
    tput cup $((lin++)) $c
    echo 'mWm'
}
new_year=$(date +'%Y')
let new_year++
tput setaf 1; tput bold

# name time poem
tput cup $lin $((c - 6)); echo MERRY CHRISTMAS Chu 
tput cup $((lin + 1)) $((c - 7)); echo And GOOD LUCK in $new_year
tput cup $((lin + 2)) $((c - 15)); echo Hang A Shining Star Upon The Highest Bow
let c++
k=1

# Lights and decorations
while true; do
    for ((i=1; i<=35; i++)) {
        # Turn off the lights
        [ $k -gt 1 ] && {
            tput setaf 2; tput bold
            tput cup ${line[$[k-1]$i]} ${column[$[k-1]$i]}; echo \*
            unset line[$[k-1]$i]; unset column[$[k-1]$i]  # Array cleanup
        }

        li=$((RANDOM % 9 + 3))
        start=$((c-li+2))
        co=$((RANDOM % (li-2) * 2 + 1 + start))
        tput setaf $color; tput bold   # Switch colors

        tput cup $li $co

        # define base pair array
        base_pair=("A" "T" "C" "G")
        # generate random number in ranage 0-3(array index)
        bp=$(($RANDOM % 4))
        # use random index to get the ele of array    
        echo ${base_pair[$bp]}
            
        line[$k$i]=$li
        column[$k$i]=$co
        color=$(((color+1)%8))
        # Flashing text
        sh=1
        for l in L U C K
        do
            tput cup $((lin+1)) $((c+sh))
            echo $l
            let sh++
            sleep 0.02
        done
    }
    k=$((k % 2 + 1))
done
