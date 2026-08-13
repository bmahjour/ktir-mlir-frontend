// RUN: ktir-opt "%s" | ktir-opt | FileCheck "%s"

// CHECK-LABEL: func.func @memspace_global
// CHECK-SAME: memref<64xf32, #ktdp.memory_space<global>>
func.func @memspace_global(%arg0: memref<64xf32, #ktdp.memory_space<global>>) -> memref<64xf32, #ktdp.memory_space<global>> {
  return %arg0 : memref<64xf32, #ktdp.memory_space<global>>
}

// CHECK-LABEL: func.func @memspace_ct_local
// CHECK-SAME: memref<64xf32, #ktdp.memory_space<ct_local>>
func.func @memspace_ct_local(%arg0: memref<64xf32, #ktdp.memory_space<ct_local>>) -> memref<64xf32, #ktdp.memory_space<ct_local>> {
  return %arg0 : memref<64xf32, #ktdp.memory_space<ct_local>>
}

// CHECK-LABEL: func.func @memspace_ct_local_ct_id
// CHECK-SAME: memref<64xf32, #ktdp.memory_space<ct_local, ct_id = 7>>
func.func @memspace_ct_local_ct_id(%arg0: memref<64xf32, #ktdp.memory_space<ct_local, ct_id = 7>>) -> memref<64xf32, #ktdp.memory_space<ct_local, ct_id = 7>> {
  return %arg0 : memref<64xf32, #ktdp.memory_space<ct_local, ct_id = 7>>
}

// CHECK-LABEL: func.func @memspace_ct_local_ct_id_zero
// CHECK-SAME: memref<64xf32, #ktdp.memory_space<ct_local, ct_id = 0>>
func.func @memspace_ct_local_ct_id_zero(%arg0: memref<64xf32, #ktdp.memory_space<ct_local, ct_id = 0>>) -> memref<64xf32, #ktdp.memory_space<ct_local, ct_id = 0>> {
  return %arg0 : memref<64xf32, #ktdp.memory_space<ct_local, ct_id = 0>>
}
