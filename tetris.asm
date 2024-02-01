
[org 0x0100] 
 jmp start 
score: db ' SCORE:'
time:db ' TIME:'
next:db ' NEXT SHAPE'
gameover:db 'GAME OVER'
startgame:db 'WELCOME TO TETRIS'
pressspace:db 'press SPACE to start game'
menu:db 'MENU'
spd1:db 'Press 1 for slow speed'
spd2:db 'Press 2 for fast speed'
spd3:db 'Press esc at any time to end game'
total: dw 0
tickcount: dw 0
oldinterrupt: dd 0
sec: dw 59
min: db 5
flag:dw 0  
nsp: dw 2582
co:dw 408
count:dw 0
shapes:dw 4
oldinterrupt1:dd 0
sh:dw 5
csh:dw 0
tt:dw 6
ns:dw 2582
speed:dw 0

gamestart:
push di
push ax
push es
push bx
mov ax,0xb800
mov es,ax
mov di, 0
nextch: mov word [es:di], 0x4020 
add di, 2 
cmp di, 4000
jne nextch
mov di,330
mov ax,0x0720
mov bx,0
it1:
mov word[es:di],ax
add di,2
add bx,2
cmp bx,140
jnz it1
add di,20
mov bx,0
cmp di,3690
jnz it1

mov ah,0eh
mov si,0
mov al,[startgame + si]
mov di,1982
mov cx,17
start_loop:
mov word[es:di],ax
add di,2
add si,1
mov al,[startgame + si]
loop start_loop

mov ah,0fh
mov si,0
mov al,[pressspace + si]
mov di,2934
mov cx,25
start_loopp:
mov word[es:di],ax
add di,2
add si,1
mov al,[pressspace + si]
loop start_loopp

pop bx
pop es
pop ax
pop di
ret

menuu:
push di
push ax
push es
push bx
mov ax,0xb800
mov es,ax
mov di, 0
nextchh: mov word [es:di], 0x4020 
add di, 2 
cmp di, 4000
jne nextchh
mov di,330
mov ax,0x0720
mov bx,0
it11:
mov word[es:di],ax
add di,2
add bx,2
cmp bx,140
jnz it11
add di,20
mov bx,0
cmp di,3690
jnz it11

mov ah,0eh
mov si,0
mov al,[menu + si]
mov di,398
mov cx,4
start_lup:
mov word[es:di],ax
add di,2
add si,1
mov al,[menu + si]
loop start_lup

add di,152
mov cx,4
underline:
mov word[es:di],0x0fc4
add di,2
loop underline

mov ah,0fh
mov si,0
mov al,[spd1 + si]
mov di,650
mov cx,22
start_lup2:
mov word[es:di],ax
add di,2
add si,1
mov al,[spd1 + si]
loop start_lup2

mov ah,0fh
mov si,0
mov al,[spd2 + si]
mov di,810
mov cx,22
start_lup3:
mov word[es:di],ax
add di,2
add si,1
mov al,[spd2 + si]
loop start_lup3

mov ah,0fh
mov si,0
mov al,[spd3 + si]
mov di,970
mov cx,33
start_lup4:
mov word[es:di],ax
add di,2
add si,1
mov al,[spd3 + si]
loop start_lup4

pop bx
pop es
pop ax
pop di
ret

stringprinting:
push ax
push es
mov ax,0xb800
mov es,ax
mov ah,0fh
mov si,0
mov al,[score + si]
mov di,652
mov cx,7
_loop:
mov word[es:di],ax
add di,2
add si,1
mov al,[score + si]
loop _loop

mov di,972
mov si,0
mov al,[time + si]
mov ah,0fh
mov cx,6
_loop2:
mov word[es:di],ax
add di,2
add si,1
mov al,[time + si]
loop _loop2


mov di,1934
mov si,0
mov al,[next + si]
mov ah,0fh
mov cx,11
_loop3:
mov word[es:di],ax
add di,2
add si,1
mov al,[next + si]
loop _loop3
mov di,2096
mov cx,10
_loop4:
mov word[es:di],0x0fc4
add di,2
loop _loop4

pop es
pop ax
ret 

interface:
push di
push ax
push es
push bx
mov ax,0xb800
mov es,ax

mov di, 0
nextchar: mov word [es:di], 0x4020 
add di, 2 
cmp di, 4000
jne nextchar

mov di,364
mov ax,0x0720
mov cx,0
itr1:
mov word[es:di],ax
add di,2
add bx,2
cmp bx,108
jnz itr1
add di,52
mov bx,0
inc cx
cmp cx,21
jne itr1

mov di,330
mov ax,0x0720
mov bx,0
itr2:
mov word[es:di],ax
add di,2
add bx,2
cmp bx,30
jnz itr2
add di,130
mov bx,0
cmp di,1610
jnz itr2


mov di,1770
mov bx,0
mov ax,0x0720
itr3:
mov word[es:di],ax
add di,2
add bx,2
cmp bx,30
jnz itr3
add di,130
mov bx,0
cmp di,3690
jnz itr3
pop bx
pop es
pop ax
pop di
call stringprinting
push di
mov di,666
call printscore
pop di

;sound
push cx
mov cx,2
call sound
pop cx

ret

printscore:
push ax
push es
push dx
mov ax,0xb800
mov es,ax
mov ax,[total]
mov cx,4
mov bx,10
pushing:
mov dx,0
div bx
add dl,0x30
push dx
loop pushing
mov cx,4
popping:
pop dx
mov dh,0x0e
mov word[es:di],dx
add di,2
loop popping
pop dx
pop es
pop ax
ret

printL:
push es
push bx
push cx
push bp
mov bp,di
mov bx, 0xb800 
mov es, bx 
mov cx,2
h1: 
mov word [es:di], ax
add di, 2 
loop h1
mov cx,2
add di,156
h2: 
mov word[es:di],ax
add di, 2 
loop h2
add di,156
mov cx,6
h3: 
mov word[es:di],ax
add di,2
loop h3
mov di,bp
pop bp
pop cx
pop bx
pop es
ret


printT:
;1f3a
push es
push bx
push cx
push bp
mov bp,di
mov bx, 0xb800 
mov es, bx 
mov cx,2
l1: 
mov word[es:di],ax
add di,2
loop l1
mov cx,2
add di,156
l2:
mov word[es:di],ax
add di,2
loop l2
add di,152
mov cx,6
l3: 
mov word[es:di],ax
add di,2
loop l3
mov di,bp
pop bp
pop cx
pop bx
pop es
ret


printSQ:
;5f3a
push es
push dx
push bx
push bp
push cx
mov dx, 0xb800 
mov es, dx 
mov bx,0
mov bp,di
loop1:
mov cx,6
loop2:
mov word[es:di],ax
add di,2
loop loop2
add bx,1
add di,148
cmp bx,3
jne loop1
mov di,bp
pop cx
pop bp
pop bx
pop dx
pop es
ret


printPlus:
;3f3a
push cx
push bx
push es
mov bx, 0xb800 
mov es, bx 
mov cx,2
mov bp,di
line1: 
mov word[es:di],ax
add di,2
loop line1
add di,152
mov cx,6
line2: 
mov word[es:di],ax
add di,2
loop line2
add di,152
mov cx,2
line3: 
mov word[es:di],ax
add di,2
loop line3
mov di,bp
pop es
pop bx
pop cx
ret

printzz:
;6f3a
push es
push bx
push cx
push bp
mov bp,di
mov bx, 0xb800 
mov es, bx 
mov cx,2
zz1: 
mov word[es:di],ax
add di,2
loop zz1
mov cx,4
add di,156
zz2:
mov word[es:di],ax
add di,2
loop zz2
mov cx,2
add di,156
zz3:
mov word[es:di],ax
add di,2
loop zz3
mov di,bp
pop bp
pop cx
pop bx
pop es
ret



game_end:
push di
push ax
push es
push bx
mov ax,0xb800
mov es,ax
mov di, 0
nextch1: mov word [es:di], 0x4020 
add di, 2 
cmp di, 4000
jne nextch1
mov di,330
mov ax,0x0720
mov bx,0
it2:
mov word[es:di],ax
add di,2
add bx,2
cmp bx,140
jnz it2
add di,20
mov bx,0
cmp di,3690
jnz it2

mov ah,0eh
mov si,0
mov al,[gameover + si]
mov di,1986
mov cx,9
start_loop2:
mov word[es:di],ax
add di,2
add si,1
mov al,[gameover + si]
loop start_loop2

mov ah,0fh
mov si,0
mov al,[score + si]
mov di,2144
mov cx,7
_loop5:
mov word[es:di],ax
add di,2
add si,1
mov al,[score + si]
loop _loop5
add di,2
call printscore

pop bx
pop es
pop ax
pop di
ret

kbisr:
push ax
push es
mov ax,0xb800
mov es,ax
mov ax,0
in al,0x60
cmp al,0x4B
jne r
call movingl
jmp end
r:
cmp al,0x4D
jne io
call movingr
jmp end
io:
cmp al,01
jne end
mov word[cs:flag],1
end:
mov al,0x20
out 0x20, al
pop es
pop ax
iret


movingr:
cmp word[cs:csh],1
je r1
cmp word[cs:csh],2
je r2
cmp word[cs:csh],3
je r3
cmp word[cs:csh],4
je r4
cmp word[cs:csh],5
je r5
r1:
call mover1
jmp ext

r2:
call mover2
jmp ext

r3:
call mover3
jmp ext

r4:
call mover4
jmp ext

r5:
call mover5
jmp ext
ext:
ret



movingl:
cmp word[cs:csh],1
je ll1
cmp word[cs:csh],2
je ll2
cmp word[cs:csh],3
je ll3
cmp word[cs:csh],4
je ll4
cmp word[cs:csh],5
je ll5

ll1:
call movel1
jmp ext1

ll2:
call movel2
jmp ext1

ll3:
call movel3
jmp ext1

ll4:
call movel4
jmp ext1

ll5:
call movel5
jmp ext1
ext1:
ret


;moveL PLUS
movel1:
push es
push bx
mov bx,0xb800
mov es,bx

push di
sub di,6
cmp word[es:di],0x0720
pop di
jne skip1

push di
sub di,2
cmp word[es:di],0x0720
pop di
jne skip1

push di
add di,154
cmp word[es:di],0x0720
pop di
jne skip1

push di
add di,318
cmp word[es:di],0x0720
pop di
jne skip1

mov ax,0x0720
call printPlus
sub di,4
mov ax,0x3f3a
call printPlus
skip1:
pop bx
pop es
ret
;moveR PLUS
mover1:
push es
push ax
mov bx,0xb800
mov es,bx

push di
add di,6
cmp word[es:di],0x0720
pop di
jne skip2

push di
add di,170
cmp word[es:di],0x0720
pop di
jne skip2

push di
add di,326
cmp word[es:di],0x0720
pop di
jne skip2

mov ax,0x0720
call printPlus
add di,4
mov ax,0x3f3a
call printPlus
skip2:
pop ax
pop es
ret












;moveL SQUARE
movel2:
push es
push bx
mov bx,0xb800
mov es,bx

push di
sub di,2
cmp word[es:di],0x0720
pop di
jne skip3

push di
add di,158
cmp word[es:di],0x0720
pop di
jne skip3

push di
add di,318
cmp word[es:di],0x0720
pop di
jne skip3

mov ax,0x0720
call printSQ
sub di,4
mov ax,0x5f3a
call printSQ
skip3:
pop bx
pop es
ret
;moveR SQUARE
mover2:
push es
push ax
mov bx,0xb800
mov es,bx

push di
add di,14
cmp word[es:di],0x0720
pop di
jne skip4

push di
add di,334
cmp word[es:di],0x0720
pop di
jne skip4

push di
add di,174
cmp word[es:di],0x0720
pop di
jne skip4


mov ax,0x0720
call printSQ
add di,4
mov ax,0x5f3a
call printSQ
skip4:
pop ax
pop es
ret


;moveL T
movel3:
push es
push bx
mov bx,0xb800
mov es,bx

push di
sub di,6
cmp word[es:di],0x0720
pop di

push di
sub di,2
cmp word[es:di],0x0720
pop di

push di
add di,158
cmp word[es:di],0x0720
pop di
push di
add di,320
sub di,6
cmp word[es:di],0x0720
pop di

jne skip5
mov ax,0x0720
call printT
sub di,4
mov ax,0x1f3a
call printT
skip5:
pop bx
pop es
ret
;moveR T
mover3:
push es
push ax
mov bx,0xb800
mov es,bx

push di
add di,8
cmp word[es:di],0x0720
pop di
jne skip6

push di
add di,168
cmp word[es:di],0x0720
pop di
jne skip6

push di
add di,330
cmp word[es:di],0x0720
pop di
jne skip6



mov ax,0x0720
call printT
add di,4
mov ax,0x1f3a
call printT
skip6:
pop ax
pop es
ret




;moveL L
movel4:
push es
push bx
mov bx,0xb800
mov es,bx

push di
sub di,2
cmp word[es:di],0x0720
pop di
jne skip7

push di
add di,158
cmp word[es:di],0x0720
pop di
jne skip7

push di
add di,318
cmp word[es:di],0x0720
pop di
jne skip7

mov ax,0x0720
call printL
sub di,4
mov ax,0x2f3a
call printL
skip7:
pop bx
pop es
ret
;moveR L
mover4:
push es
push ax
mov bx,0xb800
mov es,bx

push di
add di,6
cmp word[es:di],0x0720
pop di
jne skip8

push di
add di,166
cmp word[es:di],0x0720
pop di
jne skip8

push di
add di,334
cmp word[es:di],0x0720
pop di
jne skip8

mov ax,0x0720
call printL
add di,4
mov ax,0x2f3a
call printL
skip8:
pop ax
pop es
ret


;moveL ZZ
movel5:
push es
push bx
mov bx,0xb800
mov es,bx

push di
sub di,2
cmp word[es:di],0x0720
pop di
jne skip9

push di
add di,158
cmp word[es:di],0x0720
pop di
jne skip9

push di
add di,322
cmp word[es:di],0x0720
pop di
jne skip9



mov ax,0x0720
call printzz
sub di,4
mov ax,0x6f3a
call printzz
skip9:
pop bx
pop es
ret
;moveR ZZ
mover5:
push es
push ax
mov bx,0xb800
mov es,bx

push di
add di,6
cmp word[es:di],0x0720
pop di
jne skip10

push di
add di,170
cmp word[es:di],0x0720
pop di
jne skip10

push di
add di,330
cmp word[es:di],0x0720
pop di
jne skip10

mov ax,0x0720
call printzz
add di,4
mov ax,0x6f3a
call printzz
skip10:
pop ax
pop es
ret


deleteline:
push es
push ds
push si
push cx
push ax
push bx
mov ax,0xb800
mov es,ax
mov ds,ax
mov si,di
sub si,160
mov cx,4
loopdel:
push cx
xor cx,cx
mov cx,54
rep movsw
pop cx
sub si,268
sub di,268
loop loopdel
push di
mov di,0



red:
mov word[es:di],0x4020
add di,2
cmp di,160
jne red

;sound
push cx
mov cx,2
call sound
pop cx

pop di
pop bx
pop ax
pop cx
pop si
pop ds
pop es
ret 

row_check:
push es
push ax
push cx
push bx
mov bx,0
mov ax,0xb800
mov es,ax
mov cx,54

loopp:
cmp word[es:di],0x0720
jne nope
inc bx
nope:
add di,2
loop loopp
sub di,108
cmp bx,0
jne nah
call deleteline
add word[cs:total],2
push di
mov di,666
call printscore
pop di

nah:
pop bx
pop cx
pop ax
pop es
ret
checkentire:
push es
push ax
push cx
push di
mov ax,0xb800
mov es,ax
mov di,3564
mov cx,21
nextrow:
call row_check
sub di,160
loop nextrow
pop di
pop cx
pop ax
pop es
ret


calling:
;1=PLUS
;2=SQUARE
;3=t
;4=l
;5=zz
cmp word[cs:csh],1
je s1
cmp word[cs:csh],2
je s2
cmp word[cs:csh],3
je s3
cmp word[cs:csh],4
je s4
cmp word[cs:csh],5
je s5

s1:
mov ax,0x3f3a
call printPlus
jmp fin

s2:
mov ax,0x5f3a
call printSQ
jmp fin

s3:
mov ax,0x1f3a
call printT
jmp fin

s4:
mov ax,0x2f3a
call printL
jmp fin

s5:
mov ax,0x6f3a
call printzz
jmp fin
fin:
ret

callingb:
;1=PLUS
;2=SQUARE
;3=t
;4=l
;5=zz
cmp word[cs:csh],1
je b1
cmp word[cs:csh],2
je b2
cmp word[cs:csh],3
je b3
cmp word[cs:csh],4
je b4
cmp word[cs:csh],5
je b5

b1:
mov ax,0x0720
call printPlus
jmp fin2

b2:
mov ax,0x0720
call printSQ
jmp fin2

b3:
mov ax,0x0720
call printT
jmp fin2

b4:
mov ax,0x0720
call printL
jmp fin2

b5:
mov ax,0x0720
call printzz
jmp fin2
fin2:
ret

randnum:
push cx
push dx
push ax
rdtsc                  
xor dx,dx              
mov cx,[tt]
div cx		
mov word[cs:sh],dx      
pop ax
pop dx
pop cx
ret 

;1=PLUS
;2=SQUARE
;3=t
;4=l
;5=zz
movingdown:
cmp word[cs:csh],1
je d1
cmp word[cs:csh],2
je d2
cmp word[cs:csh],3
je d3
cmp word[cs:csh],4
je d4
cmp word[cs:csh],5
je d5

d1:
call move1
jmp ter

d2:
call move2
jmp ter

d3:
call move3
jmp ter

d4:
call move4
jmp ter

d5:
call move5
jmp ter

ter:
ret


;plus
move1:
push es
push ax
mov ax,0xb800
mov es,ax


push di
add di,480
cmp word[es:di],0x0720
pop di
jne new1

push di
add di,316
cmp word[es:di],0x0720
pop di
jne new1

push di
add di,324
cmp word[es:di],0x0720
pop di
jne new1
jmp skp1
new1:
cmp di,[co]
jne xx1
mov word[cs:flag],1
jmp end1
xx1:
mov di,[co]
call checkentire
call nextshape
call calling
jmp end1
skp1:
call callingb
add di,160
call calling
end1:
pop ax
pop es
ret

;T
move3:
push es
push ax
mov ax,0xb800
mov es,ax




push di
add di,480
cmp word[es:di],0x0720
pop di
jne new3

push di
add di,476
cmp word[es:di],0x0720
pop di
jne new3

push di
add di,484
cmp word[es:di],0x0720
pop di
jne new3
jmp skp3
new3:
cmp di,[co]
jne xx3
mov word[cs:flag],1
jmp end3
xx3:
mov di,[co]
call checkentire
call nextshape
call calling
jmp end3
skp3:
call callingb
add di,160
call calling
end3:
pop ax
pop es
ret


;sq
move2:
push es
push ax
mov ax,0xb800
mov es,ax



push di
add di,480
cmp word[es:di],0x0720
pop di
jne new2

push di
add di,484
cmp word[es:di],0x0720
pop di
jne new2

push di
add di,488
cmp word[es:di],0x0720
pop di
jne new2
jmp skp2
new2:

cmp di,[co]
jne xx3
mov word[cs:flag],1
jmp end3
xx2:

mov di,[co]
call checkentire
call nextshape
call calling
jmp end2
skp2:
call callingb
add di,160
call calling
end2:
pop ax
pop es
ret


;l
move4:
push es
push ax
mov ax,0xb800
mov es,ax




push di
add di,480
cmp word[es:di],0x0720
pop di
jne new4

push di
add di,484
cmp word[es:di],0x0720
pop di
jne new4

push di
add di,488
cmp word[es:di],0x0720
pop di
jne new4
jmp skp4
new4:

cmp di,[co]
jne xx4
mov word[cs:flag],1
jmp end4
xx4:

mov di,[co]
call checkentire
call nextshape
call calling
jmp end4
skp4:
call callingb
add di,160
call calling
end4:
pop ax
pop es
ret

;zz
move5:
push es
push ax
mov ax,0xb800
mov es,ax

push di
add di,320
cmp word[es:di],0x0720
pop di
jne new5

push di
add di,484
cmp word[es:di],0x0720
pop di
jne new5

jmp skp5
new5:

cmp di,[co]
jne xx5
mov word[cs:flag],1
jmp end5
xx5:

mov di,[co]
call checkentire
call nextshape
call calling
jmp end5
skp5:
call callingb
add di,160
call calling
end5:
pop ax
pop es
ret

nextshapecalling:
;1=PLUS
;2=SQUARE
;3=t
;4=l
;5=zz
mov ax,0x0720
call printSQ
sub di,4
mov ax,0x0720
call printSQ
add di,4

cmp word[cs:sh],1
je sh1
cmp word[cs:sh],2
je sh2
cmp word[cs:sh],3
je sh3
cmp word[cs:sh],4
je sh4
cmp word[cs:sh],5
je sh5

sh1:
mov ax,0x3f3a
call printPlus
jmp finished

sh2:
mov ax,0x5f3a
call printSQ
jmp finished

sh3:
mov ax,0x1f3a
call printT
jmp finished

sh4:
mov ax,0x2f3a
call printL
jmp finished

sh5:
mov ax,0x6f3a
call printzz
jmp finished
finished:
ret

nextshape:
push es
push ax
mov ax,0xb800
mov es,ax

push dx
mov word dx,[cs:sh]
mov word[cs:csh],dx

call randnum
push di
mov di,[nsp]
call nextshapecalling
pop di
pop dx
pop ax
pop es
ret


printsec:
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push bx 
 push cx 
 push dx 
 push di 
 mov ax, 0xb800 
 mov es, ax  
 mov ax, [bp+4]  
 mov bx, 10
 mov cx, 0 
 
 
nextdigit:
 mov dx, 0 
 div bx 
 add dl, 0x30 
 push dx 
 inc cx 
 cmp ax, 0 
 jnz nextdigit 
 mov di, 990
nextpos:
 pop dx 
 mov dh, 0x0e 
 mov [es:di], dx
 add di, 2 
 loop nextpos

mov di,986
add di,2
mov ax,0x0e3A
mov [es:di],ax

 pop di 
 pop dx 
 pop cx 
 pop bx 
 pop ax
 pop es 
 pop bp 
 ret 2 

printmin:
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push bx 
 push cx 
 push dx 
 push di 
 mov ax, 0xb800 
 mov es, ax  
 mov ax, [bp+4]  
 mov bx, 10
 mov cx, 0 
 
 
nextdigit1:
 mov dx, 0 
 div bx 
 add dl, 0x30 
 push dx 
 inc cx 
 cmp ax, 0 
 jnz nextdigit1 
 mov di, 986
nextpos1:
 pop dx 
 mov dh, 0x0e 
sub dx,1
 mov [es:di], dx
 add di, 2 
 loop nextpos1

 pop di 
 pop dx 
 pop cx 
 pop bx 
 pop ax
 pop es 
 pop bp 
 ret 2 
 

timer:
 push ax 
 push cx
 mov bx,10
 mov cx,[speed]

; cmp word[cs:pause],1
; jne continue
; resume:
; call pausescreen
; push ax
; mov ah,0x00
; int 16h
; cmp al,01
; pop ax
; mov word[cs:pause],0
; je continue
; continue:
 inc word [cs:tickcount] 
 inc word[cs:count]
 cmp word[cs:count],cx
 jne np
 mov word[cs:count],0
 call movingdown
 np:
 cmp word [cs:tickcount],18
 jne i_ret 
 mov word [cs:tickcount],0
 dec word[cs:sec]
 push word [cs:sec]  
 call printsec
 push word [cs:min]
 cmp word[cs:sec],0
 jne mint
 mov word[cs:sec],60
 dec word[cs:min]
 mint:
 call printmin
 cmp word[cs:min],0
 
 jne i_ret
 mov word[cs:flag],1
 
 i_ret:
 mov al, 0x20 
 out 0x20, al 
 pop bx 
 pop ax 
 iret 
 
sound:
push ax
push bx
mov al, 182
out 43h, al
mov ax, 2711
out 42h, al
mov al, ah
out 42h, al
in al, 61h
or al, 00000011b
out 61h, al
mov bx, cx
.pause1:
mov cx, 65535
.pause2:
dec cx
jne .pause2
dec bx
jne .pause1
in al, 61h
and al, 11111100b
out 61h, al
pop bx
pop ax
ret

 
start: 
call randnum
call gamestart
keypress:
mov ah,0x00
int 16h
cmp al,32
jne keypress
call menuu
input:
mov ah,00h
int 16h
cmp al,49
je update1
cmp al,50
je update2
jne input
update1:
mov word[cs:speed],15
jmp startt
update2:
mov word[cs:speed],3
jmp startt
startt:
call interface
call nextshape
mov di,[co]
;timer hook
xor ax, ax 
mov es, ax
mov ax, [es:8*4] 
mov [oldinterrupt], ax 
mov ax, [es:8*4+2] 
mov [oldinterrupt+2], ax 
cli 
mov word [es:8*4], timer 
mov [es:8*4+2], cs 
sti 
;keyboard hook
xor ax, ax 
 mov es, ax  
 mov ax, [es:9*4] 
 mov [oldinterrupt1], ax 
 mov ax, [es:9*4+2] 
 mov [oldinterrupt1+2], ax 
 cli 
 mov word [es:9*4], kbisr 
 mov [es:9*4+2], cs 
 sti 
un_hook:
cmp word[cs:flag],1
jne un_hook
call game_end
;timer unhook
mov ax,[oldinterrupt]
mov bx,[oldinterrupt+2]
cli
mov [es:8*4],ax
mov [es:8*4+2],bx
sti
;keyboard unhook
mov ax, [oldinterrupt1] 
 mov bx, [oldinterrupt1+2]
 cli 
 mov [es:9*4], ax 
 mov [es:9*4+2], bx 
 sti
terminate:
mov ax, 0x4c00
int 21h 