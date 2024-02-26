# Task 2 - Processes

Through this task, we want to deepen the work with structures.

The simplified structure of a process is given:

c
     struct proc{
         short pid;
         char prio;
         short time;
     };
```

---

## Exercise 1

For this part of the task you have to implement the function `sort_procs()'
in the file *sort-procs.asm* which will simulate the sorting of all currently active processes.

To better understand how a process works, we will explain below what each field of the `proc' structure means:

- The `pid' field represents the id of a process that is present in the system, whether active or inactive at the current moment, this id is unique to each process
- The `prio' field represents the priority a process has when it runs on the processor. Each process has such a priority, from 1 to 5, 1 representing the maximum running priority, and 5 representing the minimum running priority. Depending on this priority, the processes end up running earlier or later on the processor
- The `time' field represents the amount of time given to each individual process to run on the processor. Although you will encounter quite large values in this field for testing, in reality there are not such large amounts of running, because it would become unfair for the rest of the processes to wait so long after another

To sort the processes, we establish the following rules:

- The processes must appear in ascending order of processes according to priority
- For processes with the same priority, they will be ordered in ascending order according to the amount of time
- For processes with the same priority and with the same amount of time, they will be ordered in ascending order by id

Sorting will be done **in place**, that is, the `procs' vector presented below will have to be sorted after the function call. The function header is:

```
void sort_procs(struct proc *procs, int len);
```

The meaning of the arguments is:

- **procs** the starting address of the vector of processes
- **len** the number of processes in the system

**Warning!** You cannot use external functions to sort the vector.

---

## Exercise 2

In continuation of exercise 1, you must now implement the function `run_procs()` in
the file *run_procs.asm* which will calculate in a simplified way the average running time for each priority, that is, you will have to calculate the amount of time for a priority and then divide it by the number of processes that have that priority.

For this task you will have to declare an `avg' structure, which will store the amount of dividing the sum of the time amounts by the number of processes, and `remain' will store the rest of this division:

```
     struct avg{
         short quo;
         short stay;
     };
```

You will have to put the obtained values in the `avg_out' vector shown below, on the first position there is the result for priority 1, and on the last the result for priority 5. The header of the function is:

```
void run_procs(struct proc* procs, int len, struct avg *avg_out);
```

The meaning of the arguments is:

- **procs** the starting address of the vector of processes
- **len** the number of processes in the system
- **avg_out** starting address of the `avg' structure vector

**It is guaranteed that all values remain within the limits of the data types given in the structure, that is, `quo' and `remain' will not be numbers larger than 16 bits.**

## **Note**

For exercise 2, the same vector used in exercise 1 will be used. If certain values change after exercise 1, then exercise 2 will not be able to be solved correctly. The exercises are independent, however, you can choose not to do the first exercise, but you will only receive half of the score for this task.

---