#!/bin/bash
num_logs=100
num_errors=100
function show_help {
    echo "Dostępne opcje:"
    echo "- --date (-d): Wyświetla dzisiejszą datę"
    echo "- --logs [liczba] (-l): Tworzy określoną liczbę plików log z informacjami"
    echo "- --error [liczba] (-e): Tworzy określoną liczbę plików error z informacjami"
    echo "- --help (-h): Wyświetla tę pomoc"
    echo "- --init: Klonuje całe repozytorium do katalogu w którym został uruchomiony oraz ustawia ścieżkę w zmiennej środowiskowej PATH"
}

function create_gitignore {
    echo "*.log" > .gitignore
    echo "error*" >> .gitignore
}

function create_logs {
    local count=$1
    for ((i=1; i<=$count; i++)); do
        echo "Log $i" > "log$i.txt"
        echo "Nazwa skryptu: $0" >> "log$i.txt"
        echo "Data: $(date)" >> "log$i.txt"
    done
}

function create_errors {
    local count=$1
    for ((i=1; i<=$count; i++)); do
        echo "Error $i" > "error$i.txt"
        echo "Nazwa skryptu: $0" >> "error$i.txt"
        echo "Data: $(date)" >> "error$i.txt"
    done
}

function init_repo {
    git clone <url_repozytorium> ./
    export PATH=$PATH:$(pwd)
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --date|-d) echo "$(date)";;
        --logs|-l) 
            if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
                num_logs=$2
                create_logs $num_logs
                shift
            else
                echo "Błędna liczba plików log. Użyj --logs [liczba]."
                exit 1
            fi
            ;;
        --error|-e) 
            if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
                num_errors=$2
                create_errors $num_errors
                shift
            else
                echo "Błędna liczba plików error. Użyj --error [liczba]."
                exit 1
            fi
            ;;
        --init) init_repo;;
        --help|-h) show_help;;
        *) echo "Nieznana opcja: $1. Użyj --help, aby zobaczyć dostępne opcje.";;
    esac
    shift
done
create_gitignore
