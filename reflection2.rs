core::ptr::real_drop_in_place:
        ret
example::foo:
        lea     rax, [rip + .L__unnamed_1]
        ret
<u32 as example::PortDatum>::something:
        mov     eax, 45
        ret
.L__unnamed_1:
        .quad   core::ptr::real_drop_in_place
        .quad   4
        .quad   4
        .quad   <u32 as example::PortDatum>::something