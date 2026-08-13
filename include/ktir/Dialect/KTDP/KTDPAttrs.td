//===- KtdpAttrs.td - KTDP dialect attribute definitions ---*- tablegen -*-===//
//
// Attribute definitions for the ktdp dialect.
//
// Hierarchy:
//   MemorySpaceAttr  (concrete, mnemonic: memory_space)
//
//===----------------------------------------------------------------------===//

#ifndef KTDP_ATTRS_TD
#define KTDP_ATTRS_TD

include "ktir/Dialect/KTDP/KTDPDialect.td"
include "mlir/IR/AttrTypeBase.td"
include "mlir/IR/EnumAttr.td"

//===----------------------------------------------------------------------===//
// Memory-space enum
//===----------------------------------------------------------------------===//

def Ktdp_MemorySpaceKind : I32EnumAttr<
    "MemorySpaceKind",
    "KTDP memory-space enum",
    [
      I32EnumAttrCase<"global",   0, "global">,
      I32EnumAttrCase<"ct_local", 1, "ct_local">
    ]> {
  let cppNamespace = "::mlir::ktdp";
  let genSpecializedAttr = 0;
}

//===----------------------------------------------------------------------===//
// MemorySpaceAttr -- concrete memory-space attribute
//
// Assembly syntax:
//   #ktdp.memory_space<global>
//   #ktdp.memory_space<ct_local>
//   #ktdp.memory_space<ct_local, ct_id = 7>
//
// Parameters:
//   kind   -- MemorySpaceKind enum (global | ct_local)
//   ct_id  -- optional compute-tile ID (default -1 = unspecified);
//             only valid for ct_local
//===----------------------------------------------------------------------===//

def Ktdp_MemorySpaceAttr
    : AttrDef<Ktdp_Dialect, "MemorySpace"> {
  let mnemonic = "memory_space";
  let summary = "Data-parallel memory-space descriptor";
  let description = [{
    Identifies a logical memory space in the data-parallel abstraction.

    Valid values:
    - `global`   -- memory visible to all compute tiles.
    - `ct_local` -- memory local to a single compute tile.

    The optional `ct_id` parameter identifies which compute tile's local
    memory is referenced (only valid for `ct_local`).

    Examples:
    ```mlir
    memory_space = #ktdp.memory_space<global>
    memory_space = #ktdp.memory_space<ct_local>
    memory_space = #ktdp.memory_space<ct_local, ct_id = 7>
    ```
  }];

  let parameters = (ins
    "::mlir::ktdp::MemorySpaceKind":$kind,
    DefaultValuedParameter<"int32_t", "-1">:$ct_id
  );

  let assemblyFormat = "`<` $kind (`,` `ct_id` `=` $ct_id^)? `>`";

  let genVerifyDecl = 1;

  let extraClassDeclaration = [{
    /// Return true if a compute-tile ID is specified.
    bool hasCTIdSpecified() const { return getCtId() != -1; }
  }];
}

//===----------------------------------------------------------------------===//
// Runtime argument extraction kind
//===----------------------------------------------------------------------===//

def KTDP_RuntimeArgExtractKind_Value : I32EnumAttrCase<"value", 0>;
def KTDP_RuntimeArgExtractKind_Granularity : I32EnumAttrCase<"granularity", 1>;
def KTDP_RuntimeArgExtractKind_Upperbound : I32EnumAttrCase<"upperbound", 2>;

def KTDP_RuntimeArgExtractKind : I32EnumAttr<"RuntimeArgExtractKind",
    "Kind of extraction from runtime_arg type",
    [
       KTDP_RuntimeArgExtractKind_Value,
       KTDP_RuntimeArgExtractKind_Granularity,
       KTDP_RuntimeArgExtractKind_Upperbound
    ]> {
  let cppNamespace = "::mlir::ktdp";
}

#endif // KTDP_ATTRS_TD
