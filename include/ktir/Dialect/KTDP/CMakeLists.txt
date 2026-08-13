add_ktir_dialect(KTDP ktdp)
add_ktir_doc(KTDP KTDPDialect Dialects/ -gen-dialect-doc -dialect=ktdp)

set(LLVM_TARGET_DEFINITIONS KTDPAttrs.td)
mlir_tablegen(KTDPEnums.h.inc -gen-enum-decls)
mlir_tablegen(KTDPEnums.cpp.inc -gen-enum-defs)
mlir_tablegen(KTDPAttrs.h.inc -gen-attrdef-decls -attrdefs-dialect=ktdp)
mlir_tablegen(KTDPAttrs.cpp.inc -gen-attrdef-defs -attrdefs-dialect=ktdp)
add_ktir_tablegen_target(KTIRKTDPAttrsIncGen)
