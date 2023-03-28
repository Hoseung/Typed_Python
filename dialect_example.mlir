def CKKS_Dialect : Dialect {
  let name = "ckks";
  let cppNamespace = "::mlir";
  let description = [{
    This dialect represents the ciphertexts of the CKKS scheme.
  }];
}


def CKKS_CiphertextType : Type<CPred<"$_self.isa<::mlir::CKKS::ModuloArrayType>()">, "ModuloArrayType"> {
  let mnemonic = "ckks_ciphertext";
  let description = "CKKS Ciphertext type";
  let dialect = CKKS_Dialect;
}

def CKKS_AddOp : CKKS_Op<"add", [NoSideEffect]> {
  let summary = "CKKS Add operation";
  let description = [{
    This operation adds two ciphertexts.
  }];
  let arguments = (ins CKKS_CiphertextType:$lhs, CKKS_CiphertextType:$rhs);
  let results = (outs CKKS_CiphertextType:$result);
}

def CKKS_MulOp : CKKS_Op<"mul", [NoSideEffect]> {
  let summary = "CKKS Mul operation";
  let description = [{
    This operation multiplies two ciphertexts.
  }];
  let arguments = (ins CKKS_CiphertextType:$lhs, CKKS_CiphertextType:$rhs);
  let results = (outs CKKS_CiphertextType:$result);
}

def CKKS_RotateOp : CKKS_Op<"rotate", [NoSideEffect]> {
  let summary = "CKKS Rotate operation";
  let description = [{
    This operation rotates a ciphertext.
  }];
  let arguments = (ins CKKS_CiphertextType:$ciphertext, I64Attr:$rotation);
  let results = (outs CKKS_CiphertextType:$result);
}

def CKKS_RescaleOp : CKKS_Op<"rescale", [NoSideEffect]> {
  let summary = "CKKS Rescale operation";
  let description = [{
    This operation rescales a ciphertext.
  }];
  let arguments = (ins CKKS_CiphertextType:$ciphertext);
  let results = (outs CKKS_CiphertextType:$result);
}

def CKKS_BootstrapOp : CKKS_Op<"bootstrap", [NoSideEffect]> {
  let summary = "CKKS Bootstrap operation";
  let description = [{
    This operation bootstraps a ciphertext.
  }];
  let arguments = (ins CKKS_CiphertextType:$ciphertext);
  let results = (outs CKKS_CiphertextType:$result);
}
// ...