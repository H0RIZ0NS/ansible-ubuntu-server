from typing import Callable


def apply_umask(base_mode: str, umask_value: str) -> str:
    return '0{:o}'.format(int(base_mode, 8) & ~int(umask_value, 8))


class FilterModule:
    def filters(self) -> dict[str, Callable]:
        return {
            'apply_umask': apply_umask,
        }
