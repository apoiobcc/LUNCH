teacher(profAAA).
teacher(profBBB).

available(profAAA, 111).
available(profAAA, 122).

available(profBBB, 111).
available(profBBB, 211).

obrigatory(macAAA, 1).
obrigatory(macBBB, 1).

num_classes(macAAA, 2).
num_classes(macBBB, 2).

course(macAAA, 1, profAAA).
course(macBBB, 1, profBBB).