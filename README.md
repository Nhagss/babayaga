<h1>🧙‍♀️ Os Mistérios de Baba Yaga </h1>

<p>TestFlight | App Store<br>
SpriteKit • iOS • GameplayKit • Hacktoberfest</p>

<p><strong>Os Mistérios de Baba Yaga</strong> é um jogo mobile inspirado no folclore eslavo, onde magia, estratégia e aventura se unem em uma experiência encantadora.<br>
Ajude os netos de Baba Yaga a coletar ingredientes raros pela floresta — enquanto evitam perigos e desvendam mistérios ancestrais. 🌿✨</p>


<h2>📱 Sobre o jogo</h2>

<p>Baba Yaga é uma poderosa bruxa curandeira, conhecida por suas poções e conhecimentos antigos.<br>
Com sua idade avançada, ela já não consegue colher sozinha os ingredientes que crescem nas profundezas da floresta.<br>
Agora, seus netos assumem a missão de ajudar a avó — e cabe a você guiá-los nessa jornada mística.</p>

<p>A gameplay mistura <strong>movimento orbital</strong>, <strong>coleta estratégica</strong> e <strong>desvio de ameaças</strong>, tudo em um mundo mágico inspirado em tradições folclóricas.<br>
Acompanhe a jornada da família, proteja-os com magia defensiva e alterne a rotação dos personagens para sobreviver até o final.</p>



<h2>🌟 Recursos principais</h2>

<ul>
    <li>🔮 <strong>Movimento orbital dinâmico</strong> ao redor da floresta</li>
    <li>🍄 <strong>Coleta de ingredientes raros</strong> pedidos por Baba Yaga</li>
    <li>⚔️ <strong>Enfrente inimigos</strong> e desvie de obstáculos</li>
    <li>✨ <strong>Magia defensiva</strong> para proteger os personagens</li>
    <li>🔁 <strong>Altere o sentido da órbita</strong> para manobras estratégicas</li>
    <li>🌍 <strong>Transições entre planetas</strong> com escadas místicas</li>
    <li>📦 <strong>Arquitetura modular</strong> com MVC e componentes SpriteKit</li>
    <li>🧩 <strong>Engine de entidades</strong> baseada em Component-Based Architecture</li>
</ul>



<h2>🚀 Tecnologias</h2>

<p>O jogo foi desenvolvido em <strong>SpriteKit</strong> com componentes inspirados no padrão <strong>Entity-Component-System</strong>, além de:</p>

<ul>
    <li><strong>SpriteKit + GameplayKit</strong> — renderização, entidades e lógica de jogo</li>
    <li><strong>MVC Modularizado</strong></li>
    <li><strong>Componentização Visual</strong> para planetas, ingredientes e obstáculos</li>
    <li><strong>Physics Engine</strong> para colisões e interação</li>
    <li><strong>Animação Orbital</strong> via anchor points</li>
    <li><strong>Async/Await</strong> onde aplicável</li>
</ul>



<h1>🧱 Arquitetura do Projeto "BabaYaga"</h1>

<p>A estrutura do jogo foi planejada para manter clareza, escalabilidade e expansão futura.</p>

<h2>⚙️ Visão Geral</h2>
<p>O projeto utiliza <strong>SpriteKit</strong>, com arquitetura <strong>MVC</strong>, componentização e modularização.</p>



<h2>🧭 Camadas da Arquitetura</h2>

<h3>1. Model</h3>
<ul>
    <li>Contém dados e regras simples</li>
    <li>Sem dependências de SpriteKit</li>
</ul>

<h3>2. View</h3>
<ul>
    <li>SKNodes e SKSpriteNodes</li>
    <li>Responsáveis pela renderização</li>
</ul>

<h3>3. Controller</h3>
<ul>
    <li>Regras de rotação, colisão, coleta e transição</li>
    <li>Ex.: PlanetController, GameScene</li>
</ul>



<h2>🌌 GameScene</h2>

<p><strong>Arquivo:</strong> GameScene.swift<br>
<strong>Responsabilidades:</strong></p>

<ul>
    <li>Criar o mundo</li>
    <li>Gerenciar câmera</li>
    <li>Delegar física</li>
    <li>Controlar transições de planetas</li>
</ul>



<h2>🪐 PlanetController</h2>

<ul>
    <li>Gerencia rotação, coleta e obstáculos</li>
    <li>Administra PlanetView + Planet</li>
</ul>



<h2>🌍 PlanetView</h2>

<ul>
    <li>orbitAnchor para rotação</li>
    <li>playerNode</li>
    <li>obstacles</li>
    <li>ingredients</li>
</ul>



<h2>🧪 Ingredient (Model)</h2>

<pre><code>struct Ingredient {
    let id: Int;
    let name: String;
}
</code></pre>



<h2>🍬 IngredientView (View)</h2>

<ul>
    <li>Representação visual do ingrediente</li>
    <li>Física configurada</li>
</ul>



<h2>🧗 StairView</h2>

<p>Representa escadas entre planetas, ativando transições.</p>



<h2>🧲 Física e Colisões</h2>

<pre><code>enum PhysicsCategory {
    static let player: UInt32 = 0x1 << 0;
    static let obstacle: UInt32 = 0x1 << 1;
    static let ingredient: UInt32 = 0x1 << 2;
    static let stair: UInt32 = 0x1 << 3;
}
</code></pre>



<h2>🔁 Transição entre Planetas</h2>

<ol>
    <li>Player encosta na escada</li>
    <li>Sinaliza contato</li>
    <li>Botão de troca é acionado</li>
    <li>Índice do planeta muda</li>
    <li>Câmera move</li>
</ol>



<h2>📚 Organização do Projeto</h2>

<pre><code>
📁 Game  
├── GameScene.swift  
├── GameViewController.swift  

📁 Planet  
├── Planet.swift  
├── PlanetView.swift  
├── PlanetController.swift  

📁 Ingredient  
├── Ingredient.swift  
├── IngredientView.swift  

📁 UI  
├── StairView.swift  

📁 Utils  
├── PhysicsCategory.swift  
</code></pre>



<h2>🔮 Futuras Extensões</h2>

<ul>
    <li>🌐 Conexões dinâmicas entre planetas</li>
    <li>📦 Inventário persistente</li>
    <li>🧪 Crafting de poções</li>
    <li>🎲 Eventos aleatórios</li>
</ul>


### 💻 Contribuidores  

- **Daniel Oppelt** — [LinkedIn](https://www.linkedin.com/in/danieloppelt)  
- **Honório Filho** — [LinkedIn](https://www.linkedin.com/in/honoriofilho)  
- **João Roberto** — [LinkedIn](https://www.linkedin.com/in/joaorbrto)  
- **Melissa Guedes** — [LinkedIn](https://www.linkedin.com/in/melissafguedes)  
- **Yago Souza** — [LinkedIn](https://www.linkedin.com/in/yago-souza-ramos-621670211)

<h2>📄 Licença</h2>
<p>Projeto sob a <strong>MIT License</strong>.</p>



<p>Feito com magia e carinho ✨<br>
➡️ <strong>Instagram:</strong> https://www.instagram.com/playbabayaga/<br>
➡️ <strong>TestFlight:</strong> https://testflight.apple.com/join/aqRDyxRW<br>
➡️ <strong>App Store:</strong> https://apps.apple.com/br/app/os-mistérios-de-baba-yaga/id6745702574</p>

</body>
</html>
