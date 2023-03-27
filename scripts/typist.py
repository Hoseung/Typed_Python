import inspect
import ast
import typing
import functools

def type_check(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        # Get the type hints from the function definition
        type_hints = typing.get_type_hints(func)

        # Get the argument names and values from the function call
        arg_names = list(inspect.signature(func).parameters.keys())
        arg_values = dict(zip(arg_names, args))
        arg_values.update(kwargs)

        # Check if the argument values match their type hints
        for arg_name, arg_value in arg_values.items():
            expected_type = type_hints.get(arg_name)
            if expected_type and not isinstance(arg_value, expected_type):
                raise TypeError(
                    f"Argument '{arg_name}' should be of type {expected_type}, but got {type(arg_value)}"
                )

        # Call the original function if all checks pass
        return func(*args, **kwargs)

    return wrapper


class AnnotateVariableTypes(ast.NodeTransformer):
    def __init__(self):
        self.current_function = None

    # def visit_FunctionDef(self, node: ast.FunctionDef) -> ast.FunctionDef:
    #     self.current_function = node.name

    #     # Extract type annotations from function arguments
    #     arg_types: typing.Dict[str, ast.expr] = {}
    #     for arg in node.args.args:
    #         if arg.annotation:
    #             arg_types[arg.arg] = arg.annotation   
    
    def visit_Assign(self, node: ast.Assign) -> ast.AnnAssign:
        print("Visiting ASSIGN")
        inferred_type = self._infer_type(node.value)
        print("Inferred type: ", inferred_type)
        if inferred_type is not None:
            annotation = ast.Name(id=inferred_type, ctx=ast.Load())
            ann_assign = ast.AnnAssign(
                target=node.targets[0], annotation=annotation, value=node.value, simple=1
            )
            return ann_assign
        return self.generic_visit(node)

    def _infer_type(self, node: ast.AST) -> str:
        print("NODE", node)
        if isinstance(node, ast.Constant):
            return type(node.value).__name__
        # Add more type inference logic here if needed

        if isinstance(node, ast.BinOp):
            if isinstance(node.op, (ast.Add, ast.Sub, ast.Mult, ast.Div, ast.Mod, ast.Pow)):
                return "str"
        return None