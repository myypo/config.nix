# pyright: reportMissingImports=false

from typing import List
from kitty.boss import Boss
from kittens.tui.handler import result_handler


def main(args: List[str]) -> str:
    return args[0]


@result_handler(no_ui=True)
def handle_result(args: List[str], cmd: str, target_window_id: int, boss: Boss) -> None:
    win = boss.window_id_map.get(target_window_id)
    tab = boss.active_tab
    if win is None or tab is None:
        return

    if len(tab.windows) < 2:
        boss.call_remote_control(None, ("launch", "--type=window", "--cwd=current"))
    else:
        boss.call_remote_control(win, ("focus-window", "-m", "recent:1"))
