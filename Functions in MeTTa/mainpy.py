from hyperon.ext import register_atoms
from hyperon.atoms import OperationAtom
from hyperon import MeTTa

metta = MeTTa()

constant = 0
def random_variable():
    global constant
    constant += 1 
    return [metta.parse_single("(Random_Variable" + str(constant) + ")" )]

@register_atoms()
def Summarizer_for_all():
    generator = OperationAtom(
    "GenerateVariable",
    lambda raw_information: random_variable(),
    ["Atom", "Atom"],
    unwrap=False
    )
    return {r"GenerateVariable": generator}

