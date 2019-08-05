core::ptr::real_drop_in_place:
        ret
example::PortDatum::foo:
        mov     eax, 123
        ret
example::test:
        lea     rax, [rip + .L__unnamed_1]
        ret
.L__unnamed_1:
        .quad   core::ptr::real_drop_in_place
        .quad   4
        .quad   4
        .quad   example::PortDatum::foo