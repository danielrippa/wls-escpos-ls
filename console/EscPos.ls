
  do ->

    { control-chars: cc, char } = dependency 'native.String'
    { out } = dependency 'prelude.IO'
    { type-name, primitive-type: p, Num, Bool, List } = dependency 'primitive.Type'

    { esc } = cc

    item-as-string = (item) -> if item.to-string is void then String item else item.to-string!

    as-string = (value) ->

      switch type-name value
        | p.Num => char value
        | p.List => [ (item-as-string item) for item in value ].join ''

        else value

    chars = -> [ (as-string arg) for arg in arguments ] * ''

    #

    horizontal-tab = -> cc.ht

    line-feed = -> cc.lf

    carriage-return = -> cc.cr

    two-times-width = -> chars esc, cc.so

    normal-width = -> chars esc, cc.dc4

    right-side-character-spacing = (n) -> Num n ; chars esc, cc.sp, n

    print-mode = (mode) -> Num mode ; chars esc, 33, mode

    absolute-position = (l, h) -> Num l ; Num h ; chars esc, 36, l, h

    underline-mode = (mode) -> Num mode ; chars esc, 45, mode

    default-line-spacing = -> chars esc, 50

    line-spacing = (n) -> Num n ; chars esc, 51, n

    initialize = -> chars esc, 64

    international-character-sets =

      USA: 0
      France: 1
      Germany: 2
      UK: 3
      Denmark1: 4
      Sweden: 5
      Itely: 6
      Spain1: 7
      Japan: 8
      Norway: 9
      Denmark2: 10
      Spain2: 11
      LatinAmerica: 12
      Korea: 13
      SloveniaCroatia: 14
      China: 15

    international-charset = (charset) -> Num charset ; chars esc, 82, charset

    relative-horizontal-position = (l, h) -> Num l ; Num h ; chars esc, 92, n, l

    justifications =

      left: 0
      center: 1
      right: 2

    select-justification = (n) -> Num n ; chars esc, 97, n

    panel-buttons = (state) -> Bool state ; chars esc, 99, 53, if state then 1 else 0

    feed-lines = (n) -> Num n ; chars esc, 100, n

    character-code-pages =

      PC437: 0
      USA: 0
      Europe: 0
      Katakana: 1
      PC850: 2
      PC860: 3
      Portuguese: 3
      PC863: 4
      Canadian: 4
      French: 4
      PC865: 5
      Nordic: 5
      WestEurope: 6
      Greek: 7
      Hebrew: 8
      PC755: 9
      EastEurope: 9
      Iran: 10
      WPC1252: 16
      PC866: 17
      Cyrillice: 17
      PC852: 18
      Latin2: 18
      PC858: 19

    character-code-page = (code-page) -> Num code-page ; chars esc, 116, code-page

    hri-positions =

      not-printed: 0
      above: 1
      below: 2
      above-and-below: 3

    hri-characters-position = (position) -> Num position ; chars cc.gs, 72, position

    left-margin = (l, h) -> Num l ; Num h ; chars cc.gs, 76, n, l

    printing-area-width = (l, h) -> Num l ; Num h ; chars cc.gs, 87, l, h

    barcode-height = (n) -> Num n ; chars cc.gs, 104, n

    barcodes =

      m1:

        UPCA: 0
        UPCE: 1
        JAN13: 2
        EAN13: 2
        JAN8: 3
        EAN8: 3
        CODE39: 4
        ITF: 5
        CODABAR: 6

      m2:

        UPCA: 65
        UPCE: 66
        JAN13: 67
        EAN13: 67
        JAN8: 68
        EAN8: 68
        CODE39: 69
        ITF: 70
        CODABAR: 71
        CODE93: 72
        CODE128: 73

    barcode1 = (m, array) -> Num m ; List array ; chars cc.gs, 107, m, array, cc.nul

    barcode2 = (m, n, array) -> Num m ; Num n ; List array ; chars cc.gs, 107, m, n, array

    barcode-width = (n) -> chars cc.gs, 119, n

    {
      horizontal-tab, line-feed, carriage-return,
      two-times-width, normal-width, right-side-character-spacing,
      print-mode, absolute-position, underline-mode,
      default-line-spacing, line-spacing,
      initialize,
      international-charset,
      relative-horizontal-position,
      select-justification,
      panel-buttons,
      feed-lines,
      character-code-page,
      hri-characters-position,
      left-margin,
      printing-area-width,
      barcode-height,
      barcode1, barcode2,
      barcode-width,

      international-character-sets,
      justifications,
      character-code-pages,
      hri-positions,
      barcodes
    }