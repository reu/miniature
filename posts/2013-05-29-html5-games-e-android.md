title: HTML5 Games e Android
author: Lucas Pélos
date: 2013-05-30

No início da exploração, estudando, pesquisando, testando e experimentando, logo tropeçamos no primeiro impedimento técnico, o qual não deve ser novidade pra ninguém que já tenha se aventurado por esses mundos, ou simplesmente googlado a respeito: ao contrário de em iOS, jogos HTML5 não rolam em Android, ficam lento demais.

Por que? O único esclarecimento relativamente decente que encontrei foi:

<blockquote>
  <p>
    O problema com HTML5 é que há muitas camadas entre a aplicação, o input e o processamento na CPU. Há muitas verificações, "double checks", camadas de permissão e processamento de scripts na CPU, todas as quais contribuem para o atraso. Com uma aplicação nativa, você ganha acesso direto a tudo e corta caminho com o processamento do script.
  </p>
  <footer class="source">
    —
    <a href="http://stackoverflow.com/users/1356107/michael-dibbets" target="_blank">
      Michael Dibbets
    </a>
    em
    <a href="http://stackoverflow.com/questions/12513685/performance-issues-with-html5-mobile-game" target="_blank">
      StackOverflow
    </a>
  </footer>
</blockquote>

Como tanto esta fonte, quanto a maior maior parte das demais a esse respeito encontradas são relativamente antigas, naturalmente, procuramos soluções e workarounds que possam ter surgido no meio tempo, inclusive criando nossas próprias. Eis o que foi testado:

<ul>
  <li>
    Diversos jogos HTML5 disponíveis na web em aparelhos de diversas marcas e modelos rodando Android, em diversos browsers: todos com baixo fps;
  </li>
  <li>
    Criar uma app webview com uma animação simples em canvas JS através do <a href="http://www.appcelerator.com/platform/titanium-platform/" target="_blank">Titanium</a>: lento demais;
  </li>
  <li>
    Dividir as imagens utilizadas na animação em Tiles e renderizar apenas os que devem aparecer no Canvas: pequeno aumento no desempenho, porém continuando lento demais.
  </li>
  <li>
    Ativar o <a href="http://developer.android.com/guide/topics/graphics/hardware-accel.html">Hardware Acceleration</a> do Android, conforme muitos indicam: nenhuma melhora perceptível;
  </li>
  <li>
    <a href="http://www.ludei.com/tech/cocoonjs" target="_blank">CocoonJS</a>, que promete o milagre de melhorar em até 1000% o desempenho de jogos HTML5: nenhuma melhora perceptível;
  </li>
  <li>
    Desenvolver uma bridge entre a api do canvas JS e o canvas do Java para fazer com que as animações rodassem diretamente no Android, ao invés de no browser: nenhuma melhora perceptível;
  </li>
  <li>
    Criar uma aplicação webview diretamente pelo SDK do Android com o mesmo código e mesma animação: ganho de performance considerável, mas ainda lento demais.
  </li>
</ul>

Conclusão: atualmente, Android é incapaz de rodar decentemente jogos HTML5, mesmo em aparelhos com hardware superior aos dos iPhones, rodando Adnroid 4.0+.

Todavia, não abandonaremos nossos planos. Ainda planejamos que UniWorld rode perfeitamente tanto em iOS, como em Android. Continuaremos procurando soluções e compartilhando as descobertas, e acreditamos que, num futuro não muito distante, até que UniWorld esteja pronto, disponível e bombando pelo mundo, o problema terá se resolvido por si mesmo: as próximas atualizações do Android deverão trazer melhoras nesse sentido e o hardware dos smartphones, até lá, estarão consideravelmente mais potentes.