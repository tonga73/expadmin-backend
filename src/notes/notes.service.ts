import { Injectable } from '@nestjs/common';
import { CreateNoteDto } from './dto/create-note.dto';
import { UpdateNoteDto } from './dto/update-note.dto';

import { Note, Prisma } from '@prisma/client';
import { PrismaService } from '../prisma.service';

@Injectable()
export class NotesService {
  constructor(private prisma: PrismaService) {}

  create(data: Prisma.NoteCreateInput): Promise<Note> {
    return this.prisma.note.create({
      data,
    });
  }

  findAll() {
    return `This action returns all notes`;
  }

  findOne(
    noteWhereUniqueInput: Prisma.NoteWhereUniqueInput,
  ): Promise<Note | null> {
    return this.prisma.note.findUnique({
      where: noteWhereUniqueInput,
    });
  }

  update(id: number, updateNoteDto: UpdateNoteDto) {
    return `This action updates a #${id} note`;
  }

  remove(id: number) {
    return `This action removes a #${id} note`;
  }
}
