#!/bin/sh

[[ -f tasks.txt ]] || touch tasks.txt

number_of_task=$(($(cat tasks.txt | wc -l) + 1))
jobs=$*
counter=1

for job in $jobs;
do
  if [[ $counter -eq 1 ]];
  then
    first=$job
    counter=$(($counter + 1))
  fi
done

counter=1

second=""
for job in $jobs;
do
  if [[ $counter -ne 1 ]];
  then
    second+="${job} "
  fi
  counter=$(($counter + 1))
done

todoList(){
  if [[ $first == "add" ]];
  then
    if [[ $second == "" ]];
    then
      echo "[Error] This command needs an argument" >&2
      return 1
    else
      if [[ ${second,,} == *"(important)"* ]];
      then
        echo "M" $second >> tasks.txt
        echo "Added task $number_of_task with priority M"
      else
        if [[ ${second,,} == *"(very important)"* ]];
        then
          echo "H" $second >> tasks.txt
          echo "Added task $number_of_task with priority H"
        else
          echo "L" $second >> tasks.txt
          echo "Added task $number_of_task with priority L"
        fi
      fi
    fi
  else
    if [[ $first == "list" ]];
    then
      if [[ $number_of_task == 1 ]];
      then
        echo "No tasks found..."
      else
        line_number=1
        while IFS= read -r line
        do
          if [[ $line == "L "* ]];
          then
            star="*    "
            echo "$line_number ${line/L/$star}"
          else
            if [[ $line == "M "* ]];
            then
              star="***  "
              echo "$line_number ${line/M/$star}"
            else
              if [[ $line == "H "* ]];
              then
                star="*****"
                echo "$line_number ${line/H/$star}"
              fi
            fi
          fi
          line_number=$(($line_number + 1))
        done < tasks.txt
      fi
    else
      if [[ $first == "done" ]];
      then
        if [[ $second == "" ]];
        then
          echo "[Error] This command needs an argument" >&2
          return 1
        else
          content=$(sed "${second}q;d" tasks.txt)
          sed -i "${second}d" tasks.txt
          remove_char=""
          if [[ $content == "L "* ]];
          then
            second=$(($second + 0))
            echo "Completed task $second:${content/L/$remove_char}"
          else
            if [[ $content == "M "* ]];
            then
              second=$(($second + 0))
              echo "Completed task $second:${content/M/$remove_char}"
            else
              if [[ $content == "H "* ]];
              then
                second=$(($second + 0))
                echo "Completed task $second:${content/H/$remove_char}"
              fi
            fi
          fi
        fi
      else
        echo "[Error] Invalid command" >&2
        return 1
      fi
    fi
  fi
}
todoList
