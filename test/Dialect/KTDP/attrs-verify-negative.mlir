// RUN: ktir-opt "%s" -split-input-file -verify-diagnostics

// ct_id on global should fail.
func.func @memspace_global_ct_id_invalid(%arg0: memref<64xf32,
    // expected-error @+1 {{ct_id is only valid for ct_local memory spaces, but got memory space 'global' with ct_id = 2}}
    #ktdp.memory_space<global, ct_id = 2>>) {
  return
}
