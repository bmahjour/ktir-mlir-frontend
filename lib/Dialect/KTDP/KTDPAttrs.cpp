//===- KtdpAttrs.cpp - KTDP dialect attr implementations ------------------===//
//
//===----------------------------------------------------------------------===//

#include "ktir/Dialect/KTDP/KTDPAttrs.h"
#include "mlir/IR/DialectImplementation.h"

using namespace mlir;
using namespace mlir::ktdp;

//===----------------------------------------------------------------------===//
// MemorySpaceAttr::verify
//===----------------------------------------------------------------------===//

LogicalResult MemorySpaceAttr::verify(
    function_ref<InFlightDiagnostic()> emitError,
    MemorySpaceKind kind, int32_t ct_id) {
  // No ct_id specified — always valid.
  if (ct_id == -1)
    return success();

  if (ct_id < 0)
    return emitError() << "ct_id must be non-negative, but got: " << ct_id;

  if (kind != MemorySpaceKind::ct_local) {
    return emitError()
           << "ct_id is only valid for ct_local memory spaces, "
              "but got memory space '"
           << stringifyMemorySpaceKind(kind) << "' with ct_id = " << ct_id;
  }
  return success();
}
