# Todo-List
Todo List program on linux

<h3>Usage</h3>

For adding your task in list:

```
$ bash task.sh add [task text]
```

If at the end of the heading the phrase is "(important)" or "(very important)" (case-insensitive), the priority will be M and H, respectively. Otherwise the priority is L.

```L```: Low 
```M```: Medium 
```H```: High 

For show your Todo list:

```
$ bash task.sh list
```
For done your task and remove from list:

```
$ bash task.sh done [number]
```
<h3>Example</h3>

```
$ bash task.sh watch a movie at weekend
Added task 1 with priority L

$ bash task.sh add "Fix bug #73 (very important)"
Added task 2 with priority H

$ bash task.sh add Prepare presentation "(Important)"
Added task 3 with priority M

$ bash task.sh list
1 *     watch a movie at weekend
2 ***** Fix bug #73 (very important)
3 ***   Prepare presentation (Important)

$ bash task.sh done 2
Completed task 2: Fix bug #73 (very important)

$ bash task.sh list
1 *     Plan for summer
2 ***   Prepare presentation (Important)
```
