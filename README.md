# Aerial Artillery Range Table Calculator

## Material

### Mathematics
 * Wurfparabel (englisch): <https://en.wikipedia.org/wiki/Projectile_motion>
 * WB.se Airship Aiming: <https://worldbuilding.stackexchange.com/questions/130432/how-to-correct-aim-in-aerial-airship-combat/131416#131416>
 * Curvature of the Earth: https://www.mathscinotes.com/2017/12/earths-curvature-and-battleship-gunnery/
   * https://www.mathscinotes.com/2017/12/earths-curvature-and-battleship-gunnery/#comment-59100
   * https://www.mathscinotes.com/2017/12/earths-curvature-and-battleship-gunnery/#comment-59104
   * https://www.mathscinotes.com/2017/12/earths-curvature-and-battleship-gunnery/#comment-59187
   * https://www.mathscinotes.com/2017/12/earths-curvature-and-battleship-gunnery/#comment-60510
   * (Riflemans Rule) https://www.mathscinotes.com/2017/12/earths-curvature-and-battleship-gunnery/#comment-105695

### Sources
 * Artillery over the Ages: https://www.gutenberg.org/files/20483/20483-h/20483-h.htm
 * Naval Gunfire Characteristics: https://fas.org/man/dod-101/sys/ship/weaps/gunfire-table.gif
 * Skoda Guns on Austrian Waship: http://www.navweaps.com/Weapons/WNAust_12-45.php

## Setup

### Install Stack

For Windows install the `haskell-stack`-package from Chocolatey: <https://chocolatey.org/packages/haskell-stack>.

For other platforms see <https://docs.haskellstack.org/en/stable/install_and_upgrade/>.

### Install Make (optional)

For Windows install the `make`-package from Chocolatey: <https://chocolatey.org/packages/make>

For other platforms consult the respective package repository to find the `make`-package.

### Install GHC (and dependencies)

Run `stack install` in repository.

## Run

Execute `make run`. Or `stack build` `stack exec aartc-exe` if `make` is not available.
