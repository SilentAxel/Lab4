#!/bin/bash
num_logs=100

function show_help {
    echo "Dostępne opcje:"
    echo "- --date: Wyświetla dzisiejszą datę"
    echo "- --logs [liczba]: Tworzy określoną liczbę plików log z informacjami"
    echo "- --help: Wyświetla tę pomoc"
}

function create_gitignore {
    echo "*.log" > .gitignore
}

function create_logs {
    local count=$1
    for ((i=1; i<=$count; i++)); do
        echo "Log $i" > "log$i.txt"
        echo "Nazwa skryptu: $0" >> "log$i.txt"
        echo "Data: $(date)" >> "log$i.txt"
    done
}

function create_tag {
    git tag -a v1.0 -m "Wersja 1.0"
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --date) echo "$(date)";;
        --logs) 
            if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
                num_logs=$2
                create_logs $num_logs
                shift
            else
                echo "Błędna liczba plików log. Użyj --logs [liczba]."
                exit 1
            fi
            ;;
        --help) show_help;;
        *) echo "Nieznana opcja: $1. Użyj --help, aby zobaczyć dostępne opcje.";;
    esac
    shift
done

create_gitignore

create_tag
