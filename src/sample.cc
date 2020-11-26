/*
//@HEADER
// *****************************************************************************
//
//                                  sample.cc
//                           DARMA Toolkit v. 1.0.0
//                           DARMA/vt-sample-project
//
// Copyright 2019 National Technology & Engineering Solutions of Sandia, LLC
// (NTESS). Under the terms of Contract DE-NA0003525 with NTESS, the U.S.
// Government retains certain rights in this software.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// * Neither the name of the copyright holder nor the names of its
//   contributors may be used to endorse or promote products derived from this
//   software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//
// Questions? Contact darma@sandia.gov
//
// *****************************************************************************
//@HEADER
*/


#include "sample.h"

#include <vt/transport.h>
#include <fmt/format.h>

#include <cassert>

namespace sample {

static void handler(MyMsg* msg) {
  fmt::print("{}: running handler\n", vt::theContext()->getNode());
  assert(msg->v_.size() == 100 && "Must be the correct size");
  for (int i = 0; i < 100; i++) {
    assert(msg->v_.at(i) == i && "Must be equal");
  }
}

} /* end namespace sample */

int main(int argc, char** argv) {
  vt::initialize(argc, argv);

  auto this_node = vt::theContext()->getNode();
  auto num_nodes = vt::theContext()->getNumNodes();

  fmt::print("{}: running sample program: num_nodes={}\n", this_node, num_nodes);

  if (this_node == 0 && num_nodes > 1) {
    auto msg = vt::makeMessage<sample::MyMsg>();
    for (int i = 0; i < 100; i++) {
      msg->v_.push_back(i);
    }
    vt::theMsg()->sendMsg<sample::MyMsg, sample::handler>(1, msg);
  }

  vt::finalize();
  return 0;
}
